#!/usr/bin/env ruby
MATCH=Regexp.new ARGV[0] || '.*'
Dir['**/*.jar'].each do |jar|
    # puts jar
    cmd = ['bash', '-c', 'jar tf "%s" 2>&1' % [jar]]
    IO.popen cmd do |proc|
        proc.each do |line|
            if m = MATCH.match(line)
                puts "%s - %s" % [jar, line]
            end
        end
    end
end
