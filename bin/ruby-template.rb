#!/usr/bin/env ruby
# frozen_string_literal: true

# For use with Gemfile and bundler
require 'bundler/setup'

require 'aws-sdk-core' # add service gems as needed, e.g. aws-sdk-s3
require 'optparse' # command line option parser
require 'yaml'

class MyClass

    Options = Struct.new(:ok, :quiet, :yes, :profile, :region, :operations)

    attr_accessor :options

    def parse(args)
        _opts = Options.new(
            ok: false,
            quiet: false,
            yes: false,
            profile: 'default',
            region: 'us-west-2',
            operations: []
        )

        opt_parser = OptionParser.new do |o|
            o.banner = 'Description'
            o.separator ''
            o.separator "Usage #{File.basename $PROGRAM_NAME} [options]"
            o.separator ''
            o.separator 'Specific options:'

            o.set_summary_width(15)

            # -------------------------
            # Amazon options
            o.on('--profile pname', 'AWS profile name') do |profile|
                _opts.profile = profile
            end

            o.on('--region region', 'AWS region') do |region|
                _opts.region = region
            end

            o.separator ''
            o.separator 'Common options:'
            o.on('-q', 'Quiet operation') do |bool|
                _opts.quiet = bool
            end

            o.on('-l', '--list', 'List items') do |_bool|
                _opts.operations << method(:do_list)
            end

            o.on('-h', 'Print this usage') do
                puts o
                puts dump(_opts)
                exit
            end

            o.separator ''
            o.separator 'Examples:'
            o.separator " #{File.basename $PROGRAM_NAME} -l "
            o.separator '      List all components'
            o.separator ''
        end

        begin
            opt_parser.parse!(args)
        rescue OptionParser::ParseError => e
            puts e
            puts opt_parser
            exit 1
        end

        if _opts.operations.empty?
            puts opt_parser
            puts dump(_opts)
            exit 0
        end

        # return options
        _opts
    end

    def main(args)
        puts "args: #{args}"
        self.options = parse(args)
        puts "options: #{options.members}"
        options.operations.each do |cmd|
            cmd&.call
        end
    end

    def dump(opts)
        opts.to_h.except(:operations).transform_keys(&:to_s).to_yaml
    end

    def do_list
        p 'do list'
    end
end

MyClass.new.main ARGV
