#!/usr/bin/env perl
#
# Combine log4j logs and system logs
# logCombiner.pl file1 file2 file3
#
# Assumes the logs are timestamped sequencially.
#
# For log4j it groups multiline records.
#
# Converts syslog times to log4j format.
# Converts in.tftpd times from "GMT".
#
# Myron Overton 2006-11-16
# --------------------------------------

use Date::Manip;
use IO::File;

$|=1;

# regexp for record header: 2006-11-05 20:03:25,723 [main] ERROR...
$log4j_date = q{(^\d\d\d\d-\d\d-\d\d\s\d\d:\d\d:\d\d,\d\d\d)\s*};
$log4j_re   = qr{$log4j_date};
# regexp for record header:   [java] 2006-11-05 20:03:25,723 [main] ERROR...
$churn_date = q{^\s+\[\w+\]\s(\d\d\d\d-\d\d-\d\d\s\d\d:\d\d:\d\d,\d\d\d)\s*};
$churn_re   = qr{$churn_date};
# syslog date: Nov 14 23:29:29 xxxxxxx
$sys_date = q{(^\w\w\w\s[\s\d]\d\s\d\d:\d\d:\d\d)};
$sys_re   = qr{$sys_date};
# --------------------------------------

@data = ();

main( \@data, @ARGV);

# --------------------------------------
sub main {
    my $data = shift;
    openfiles( $data, @_ );
    print_hdr( $data );
    process_recs( $data );
}
# --------------------------------------
sub openfiles {
    my $data = shift;
    my @x = ();
    my $cnt = 0;
    for my $f (@_) {
        if( ! -f "$f" || ! -T "$f" ) {
            die "$f is not a text file\n";
        }
        my $in;
        open( $in, "$f" ) or die "Cannot open $f\n";
        my $tmp = {};
        $tmp->{file} = "$f";
        $tmp->{ndx} = $cnt++;
        $tmp->{fd}   = $in;
        push( @$data, $tmp );
    }
}
# --------------------------------------
sub print_hdr {
    my $data = shift;
    print '-' x 40, "\n";
    print "Index table:\n";
    for my $v (@$data) {
        print "<date>-$v->{ndx}- = $v->{file}\n";
    }
    print '-' x 40, "\n";
}
# --------------------------------------
sub print_rec {
    my $data = shift;
    my $rec  = $data->{rec};
    for my $l (@{$rec->{data}}) {
        if( $rec->{date} ) {
            print "$l\n";
        } else {
            print "-$data->{ndx}- $l\n";
        }
    }
}
# --------------------------------------
sub read_rec {

    my $data = shift;

    return undef if( $data->{closed} );

    my $in   = $data->{fd};
    my $ndx  = $data->{ndx};
    my $rec  = $data->{rec};
    my $date = $rec->{lastdate};
    my $line = "";
    my $running = 1;

    if( $date ) {
        $rec->{date} = $date;
    }

    my @tmp = ();

    if( defined $rec->{lastline} ) {
        push( @tmp, $rec->{lastline} );
    }

    while( $running ) {

        unless( defined( $line = <$in> ) ) {
            $data->{closed} = 1;
            last;
        }

        chop $line;

        if ( $line =~ m/$log4j_re/ ) {
            $rec->{lastdate} = "$1-$ndx-";
            $line =~ s/$log4j_re/$rec->{lastdate}/;
            $rec->{lastline} = "$line";
            last;
        } elsif ( $line =~ m/$churn_re/ ) {
            $rec->{lastdate} = "$1-$ndx-";
            $line =~ s/$churn_re/$rec->{lastdate}/;
            $rec->{lastline} = "$line";
            last;
        } elsif ( $line =~ m/$sys_re/ ) {
            my $date = "$1";
            $date = ParseDate( $date );
            if( $line =~ m/in\.tftpd/ ) {
                $date = Date_ConvTZ( $date, "GMT" );
            }
            # 2006111423:29:29 to 2006-11-14 23:29:29
            $date =~ s/(^\d\d\d\d)(\d\d)(\d\d)(.*)\s*/$1-$2-$3 $4    -$ndx-/;
            $line =~ s/$sys_re/$date/;

            $rec->{lastline} = "$line";
            $rec->{lastdate} = "$date";
            last;
        } else {
            push( @tmp, "$line" );
        }
    }

    $rec->{data} = [ @tmp ];
    $data->{rec} = $rec;
    return $rec;
}
# --------------------------------------
sub process_recs {
    my $data = shift;
    for my $v (@$data) {
        my $r = read_rec($v);
        if( ! defined $r->{date} ) {
            print_rec( $v );
            read_rec( $v );
        }
    }
    # ----
    $running = 1;
    while( $running ) {
        my @dates = ();
        for my $v (@$data) {
            unless( defined $v->{closed} ) {
                push( @dates, $v->{rec}->{date} );
            }
        }
        last unless( @dates );
        #map { print "Date: $_\n"; } sort @dates;
        my $top = (sort @dates)[0];
        #print "Top: $top\n";
        for my $v (@$data) {
            if( "$top" eq "$v->{rec}->{date}" ) {
                print_rec( $v );
                read_rec( $v );
                last;
            }
        }
    }
}
# --------------------------------------
exit;
# --------------------------------------
