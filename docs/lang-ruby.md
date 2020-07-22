---
layout: default
---
- [home](/index.md)
- [lang](/lang.md)

---
## Rails
- [rails](/lang-ruby-rails.md)
## Docs
- <http://ruby-doc.org/>
---
## Kernel
- <https://ruby-doc.org/core-2.7.1/Kernel.html>
Lots of goodness

## Open
- <https://ruby-doc.org/core-2.7.1/Kernel.html#method-i-open>
- <https://ruby-doc.org/core-2.7.1/IO.html#method-c-open>
```
open("testfile") do |f|
  print f.gets
end
# pipe
cmd = open("|date")
print cmd.gets
cmd.close

```
## Unbuffered output
```
$stdout.sync = true
$stderr.sync = true
```

## Add this comment to top of ruby file.
```
encoding: utf-8

ENV_JAVA['file.encoding']
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
JAVA_OPTS=-Dfile.encoding=UTF-8

# look these up
:startdoc:
:stopdoc:
:nodoc:
```

## Comment out blocks with =begin and =end at start of line
```
#!/usr/bin/env ruby
=begin
Every body mentioned this way
to have multiline comments.

The =begin and =end must be at the beginning of the line or
it will be a syntax error.
=end

puts "Hello world!"

<<-DOC
Also, you could create a docstring.
which...
DOC

puts "Hello world!"

"..is kinda ugly and creates
a String instance, but I know one guy
with a Smalltalk background, who
does this."

puts "Hello world!"

##
# most
# people
# do
# this

# read data from __END__ with DATA.each_line
__END__

But all forgot there is another option.
Only at the end of a file, of course.
```

## Install debugger for RubyMine
```
gem install debase --version '0.2.2.beta10'
gem install ruby-debug-ide --version '0.6.1.beta9'
```

## Disable docs on gem install
- [how-to-make-no-ri-no-rdoc-the-default-for-gem-install](https://stackoverflow.com/questions/1381725/how-to-make-no-ri-no-rdoc-the-default-for-gem-install)
```
-N # cli option
cat > ~/.gemrc <<EOF
gem: --no-rdoc --no-ri
EOF
```

## print backtraces
```
begin
  Whatever.you.want
rescue => e
  puts e.message
  puts
  # filter gems and fix path
  puts e.backtrace.grep_v(/\/gems\//).map { |l|
    l.gsub(`pwd`.strip + '/', '')
  }
  raise # always reraise
end
```

# File
```
DIR_HOME = File.expand_path File.dirname __FILE__
DIR_LIB  = File.join(DIR_HOME, 'lib')
$LOAD_PATH.unshift DIR_LIB unless $LOAD_PATH.include? DIR_LIB
```

## Use require_relative instead of adding to LOAD_PATH
```
require_relative 'lib/ServerlessOptions'
```

## profiler
```
prof = []
prof << Time.now
prof << Time.now
prof << Time.now
prof[0..-2].zip(prof[1..-1]).each.with_index do |i,n|
    Rails.logger.info "%4d: %.6f" % [n, i[1] - i[0]]
end
```

## pipe remove color escapes
```
cat or echo x |ruby -ne 'print $_.gsub(/\e\[[\d\;]*m/,"");'
```

## Misc
```
puts URI.unescape get_user_policy( user_name:'jenkins.lambdas', policy_name:'jenkins-lambdas').policy_document
```

## plumb the view
```
rr g controller hello_angular index
```
***

## Random String

```
require 'securerandom'
SecureRandom.hex(32)
```

# Version managers
Look here to find different implementations 
- Currently [asdf-vm](/tools-asdf.md) is the best
- <https://github.com/rbenv/rbenv>
- <https://rvm.io/>

# Bundler
```
gem install bundler
bundle init # creates Gemfile for new project
bundle # install contents of Gemfile

# Add to top of scripts for auth bundle exec
#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'

```
