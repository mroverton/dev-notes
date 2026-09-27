#!/usr/bin/env ruby
# frozen_string_literal: true

WORKER_CNT = 8

class GitAll
    def initialize
        @work_in  = Queue.new
        @work_out = Queue.new
        @workers = []
        @quiet = false
    end

    def enqueue(item)
        @work_in << item
        start_workers
    end

    def start_workers
        while @workers.length < [@work_in.length, WORKER_CNT].min
            @workers << Thread.new do
                # pop returns nil once the queue is closed and drained
                while (dir = @work_in.pop)
                    full_path = File.join(@wd, dir)
                    next unless File.exist?(File.join(full_path, '.git'))

                    mybranch = IO.popen(['git', '-C', full_path, 'describe', '--contains', '--all', 'HEAD'],
                                        err: %i[child out], &:read).strip
                    res = @quiet ? +'' : "#{'-' * 40}\n#{full_path} (#{mybranch})\n"
                    res << IO.popen(['git', '-C', full_path, *@args], err: %i[child out], &:read)
                    res << "\n" unless res.empty? || res.end_with?("\n")
                    @work_out.push res
                end
            end
        end
    end

    def workers_running?
        @workers.any?(&:alive?)
    end

    def wait_for_workers
        @work_in.close
        while workers_running?
            puts @work_out.pop until @work_out.empty?
            sleep 0.5
        end
        puts @work_out.pop until @work_out.empty?
    end

    def usage
        puts <<~USAGE

            #{$PROGRAM_NAME} [-q] <option string passed to git>
                This command finds .git sub-directories and calls git with your options for each.
                -q does not print the separator and directory path

        USAGE
        exit 1
    end

    def main(args)
        usage if args.empty?
        @quiet = args.first == '-q'
        args.shift if @quiet

        unless @quiet
            puts '=' * 80
            puts "git #{args.join(' ')}"
        end

        @args = args
        @wd = Dir.pwd
        Dir['**/.git'].each { |d| enqueue File.dirname(d) }
        wait_for_workers
    end
end

GitAll.new.main ARGV
