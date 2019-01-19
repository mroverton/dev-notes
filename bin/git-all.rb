#!/usr/bin/env ruby
require 'thread'

WORKER_CNT = 8

class GitAll
    def initialize
        @work_in  = Queue.new
        @work_out = Queue.new
        @worker_mutex = Mutex.new
        @workers = []
        @done = false
        @quiet = false
    end

    def enqueue(item)
        @work_in << item
        ensure_workers_running
    end

    def ensure_workers_running
        # return if workers_running?
        @worker_mutex.synchronize do
            # return if workers_running?
            start_workers
            while true
                if workers_running?
                    break
                end
                sleep 1
            end
        end
    end

    def workers_running?
        res = false
        @workers.each do |w|
            if w.alive?
                res = true
                break
            end
        end
        return res
    end

    def start_workers
        while @workers.length < ([@work_in.length, WORKER_CNT].min)
            @workers << Thread.new do
                while true
                    if @done && @work_in.empty?
                        break
                    end
                    d2 = @work_in.pop
                    full_path = @wd + '/' + d2
                    if not File.directory?(full_path + "/.git")
                        continue
                    end
                    mybranch = ""
                    cmd = ['bash', '-c', 'cd %s; git describe --contains --all HEAD 2>&1' % [full_path]]
                    IO.popen cmd do |proc|
                        mybranch= proc.read.strip
                    end
                    cmd = ['bash', '-c', 'cd %s; git "%s" 2>&1' % [full_path, @args.join('" "')]]
                    res = (@quiet ? '' : '-' * 40 + "\n#{full_path} (#{mybranch})\n")
                    IO.popen cmd do |proc|
                        res =  res + proc.read
                    end
                    unless res.empty?
                        res += "\n" unless res.end_with? "\n"
                    end
                    @work_out.push res
                end
                # puts "Worker exit"
            end
            # puts "Workers: %d" % @workers.length
        end
    end

    def wait_for_workers
        @done = true
        while workers_running?
            while not @work_out.empty?
                puts @work_out.pop
            end
            sleep 0.5
        end
        while not @work_out.empty?
            puts @work_out.pop
        end
    end

    def usage
        puts %Q(

    #{$0} [-q] <option string passed to git>
        This command finds .git sub-directories and calls git with your options for each.
        -q does not print the separator and directory path


)
        exit 1
    end

    def main(args)
        usage if args.empty?
        if args[0] == '-q'
            args.shift
            @quiet = true
        end

        unless @quiet
            puts '=' * 80
            puts "git #{args.join(" ")}"
        end

        @args = args
        @wd = Dir.pwd
        Dir['**/.git'].map {|d| enqueue d[0..-6]}
        wait_for_workers
    end
end

GitAll.new.main ARGV
