#!/usr/bin/env ruby
# frozen_string_literal: true

MATCH = Regexp.new(ARGV[0] || '.*')
Dir['**/*.jar'].each do |jar|
    IO.popen(['jar', 'tf', jar], err: %i[child out]) do |proc|
        proc.each do |line|
            puts "#{jar} - #{line}" if MATCH.match?(line)
        end
    end
end
