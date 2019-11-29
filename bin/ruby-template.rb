#!/usr/bin/env ruby

require 'aws-sdk'
require 'optparse' # command line option parser
require 'ostruct'  # struct holding parsed options
require 'pp'       # pretty printer

class MyClass

    @options = nil

    class << self
        attr_accessor :options
    end

    def self.parse(args)

        _opts            = OpenStruct.new
        _opts.ok         = false
        _opts.quiet      = false
        _opts.yes        = false
        _opts.profile    = 'default'
        _opts.region     = 'us-west-2'
        _opts.operations = []

        opt_parser = OptionParser.new do |o|

            o.banner  = 'Description'
            o.separator ''
            o.separator "Usage #{File.basename $0} [options]"
            o.separator ''
            o.separator 'Specific options:'

            o.set_summary_width(15)

            # -------------------------
            # Amazon options
            o.on('--profile pname', 'AWS profile name') do |profile|
                _opts.aws_profile = profile
            end

            o.on('--region region', 'AWS region') do |region|
                _opts.aws_region = region
            end

            o.separator ''
            o.separator 'Common options:'
            o.on('-q', 'Quiet operation') do |bool|
                _opts.quiet = bool
            end

            o.on('-l', 'List') do |bool|
                _opts.operations << method(:do_list)
            end

            o.on('-h', 'Print this usage') do
                puts o
                puts _opts.to_yaml
                exit
            end

            o.separator ''
            o.separator 'Examples:'
            o.separator " #{File.basename $0} -l "
            o.separator '      List all components'
            o.separator ''

        end

        opt_parser.parse!(args)

        unless _opts.ok
            STDOUT.puts opt_parser
            puts _opts.to_yaml
            exit 0
        end

        # return options
        _opts
    end

    def self.main(args)
        puts "args: #{args}"
        self.options = parse args
        puts "options: #{options.keys
        options.operations.each do |cmd|
            cmd.call() if cmd
        end
    end
end

Serverless.main ARGV
