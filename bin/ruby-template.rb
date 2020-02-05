#!/usr/bin/env ruby

require 'aws-sdk'
require 'optparse' # command line option parser
require 'ostruct' # struct holding parsed options
require 'pp' # pretty printer

class MyClass

    attr_accessor :options

    def parse(args)
        _opts = OpenStruct.new
        _opts.ok = false
        _opts.quiet = false
        _opts.yes = false
        _opts.profile = 'default'
        _opts.region = 'us-west-2'
        _opts.operations = []

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

            o.on('-l', '--list', 'List items') do |_bool|
                _opts.operations << method(:do_list)
            end

            o.on('-h', 'Print this usage') do
                puts o
                puts _opts.to_yaml
                exit
            end

            o.separator ''
            o.separator 'Examples:'
            o.separator " #{File.basename $PROGRAM_NAME} -l "
            o.separator '      List all components'
            o.separator ''
        end

        opt_parser.parse!(args)

        if _opts.operations.empty?
            STDOUT.puts opt_parser
            puts _opts.to_yaml
            exit 0
        end

        # return options
        _opts
    end

    def main(args)
        puts "args: #{args}"
        self.options = parse(args)
        puts "options: #{options.keys}"
        options.operations.each do |cmd|
            cmd&.call
        end
    end

    def do_list
        p 'do list'
    end
end

MyClass.new.main ARGV
