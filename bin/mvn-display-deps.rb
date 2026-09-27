#!/usr/bin/env ruby
# frozen_string_literal: true

def usage
  puts <<~USAGE

    #{$PROGRAM_NAME} file

    Processes the output of mvn versions:display-dependency-updates

  USAGE
  exit 1
end

usage unless ARGV[0]

puts File.read(ARGV[0])
         .gsub(/^\[INFO\]/, '')
         .gsub(/\.{3}\n\s+/, ' ')
