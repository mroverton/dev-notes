#!/usr/bin/env ruby
require 'thread'

require_relative 'StringColor'

WORKER_CNT = 8

class ProcessQueue

    class CaptureBuffer
        attr_accessor :buffer

        def initialize
            self.buffer = ''
        end

        def add(str)
            buffer.insert(-1, str)
        end
    end

    class Cmd
        attr_accessor :title, :cmd, :capture_buf

        def initialize(title, cmd, capture_buf = nil)
            unless title.instance_of? String
                raise 'ProcessQueue::Cmd title must be string'
            end
            self.title = title
            if capture_buf
                unless capture_buf.instance_of? CaptureBuffer
                    msg = 'capture_buf must be of type ProcessQueue::CaptureBuffer'
                    STDERR.puts msg
                    throw msg
                end
                self.capture_buf = capture_buf
            end
            case cmd
            when String
                self.cmd = [cmd]
            when Array
                self.cmd = cmd
                cmd.each do |c|
                    unless c.instance_of? String
                        raise 'ProcessQueue::Cmd cmd array items must be strings'
                    end
                end
            else
                raise 'ProcessQueue::Cmd cmd must be string or Array of strings'
            end
        end
    end

    def initialize(worker_cnt: WORKER_CNT,
        verbose: false,
        stop_on_error: false,
        no_color: false,
        dryrun: false)

        @success       = true
        @work_cnt      = 0
        @work_in       = Queue.new
        @work_out      = Queue.new
        @worker_cnt    = worker_cnt.to_i
        @worker_cnt    = 1 if @worker_cnt == 0
        @worker_list   = []
        @verbose       = verbose
        @stop_on_error = stop_on_error
        @no_color      = no_color
        @dryrun        = dryrun
        # puts inspect
    end

    def push(cmd)
        if work_in.closed?
            STDERR.puts 'ERROR: queue closed'
            return
        end
        unless cmd.instance_of? Cmd
            raise 'Input must be type ProcessQueue::Cmd'
        end
        @work_cnt += 1
        if @no_color
            cmd.title = "%4d. %s" % [work_cnt, cmd.title]
        else
            cmd.title = StringColor.colorize(work_cnt, "%4d. %s" % [work_cnt, cmd.title])
        end
        work_in << cmd
        ensure_workers_running
    end

    def wait
        work_in.close
        while workers_running?
            while not work_out.empty?
                puts work_out.pop
            end
            sleep 0.5
        end
        while not work_out.empty?
            puts work_out.pop
        end
        result = @success
        reset
        result
    end

    private

    attr_accessor :work_cnt
    attr_accessor :work_in
    attr_accessor :work_out
    attr_accessor :worker_lock
    attr_accessor :worker_list
    attr_accessor :worker_cnt
    attr_accessor :verbose
    attr_accessor :dryrun

    def reset
        @success     = true
        @work_in     = Queue.new
        @work_out    = Queue.new
        @worker_list = []
        @work_cnt    = 0
    end

    def ensure_workers_running
        start_workers
        while true
            if workers_running?
                break
            end
            sleep 1
        end
    end

    def workers_running?
        res = false
        worker_list.each do |w|
            if w.alive?
                res = true
                break
            end
        end
        return res
    end

    def failed
        @success = false
        if @stop_on_error
            work_out.push 'Stopping all work'
            work_in.close
            work_in.clear
        end
    end

    def start_workers
        while worker_list.length < ([work_in.length, worker_cnt].min)
            worker_list << Thread.new do
                begin
                    while true
                        if work_in.closed? && work_in.empty?
                            break
                        end
                        input1 = work_in.pop # input is array
                        next unless input1
                        # puts "input: #{input1.inspect}"
                        title1 = input1.title
                        cmd1   = ['bash', '-c'] + input1.cmd
                        res    = ''
                        if verbose
                            work_out.push "%s: %s" % [title1, input1.cmd.join(' ')]
                        else
                            res = '-' * 40 + "\n#{title1}: #{input1.cmd.join ' '}\n"
                        end
                        if @dryrun
                            work_out.push "DRYRUN: #{cmd1}"
                            next
                        end
                        IO.popen cmd1, :err => [:child, :out] do |proc|
                            while s = proc.gets
                                break unless s
                                input1.capture_buf.add s if input1.capture_buf
                                if @no_color
                                    s.gsub! /\e\[\d+m/, ''
                                end
                                if verbose
                                    work_out.push "%s: %s" % [title1, s]
                                else
                                    res = res + s
                                end
                                sleep 0.01 # force a re-schedule
                            end
                        end
                        unless 0 == $?.exitstatus
                            work_out.push "%s: %s" % [title1, 'Process failed']
                            failed
                        end
                        unless res.empty?
                            res += "\n" unless res.end_with? "\n"
                            work_out.push res
                        end
                    end
                rescue Exception => e
                    STDERR.puts("ProcessQueue worker error: #{e}")
                    raise
                end
            end
            sleep 0.01 # force a re-schedule
        end
    end
end
