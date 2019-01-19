#!/usr/bin/env ruby


def usage
  puts "
    #{$0} file

    Processes the output of mvn versions:display-dependency-updates

  "
  exit 1
end

unless ARGV[0]
  usage
end


File.open(ARGV[0]) do |f|
  data = f.read
  data.gsub! /^\[INFO\]/, ''
  data.gsub! /\.{3}\n\s+/, ' '
  puts data
end
