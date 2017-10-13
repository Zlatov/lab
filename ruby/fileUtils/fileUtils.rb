require 'rubygems'
require 'fileutils'

# FileUtils.mkdir 'a'
# FileUtils.mkdir 'b'
FileUtils.mkdir_p 'a'
FileUtils.mkdir_p 'b'

File.open('a/a', 'w+') if !File.exist?('a/a')
File.open('a/b', 'w+') if !File.exist?('a/b')

FileUtils.mv Dir['a/*'], 'b'
FileUtils.mv Dir['b/*'], 'a'

p Dir['a/*']

File.open('b/a', 'w+') if !File.exist?('b/a')
File.open('b/b', 'w+') if !File.exist?('b/b')

p Dir['b/*']

FileUtils.rm_rf Dir.glob('b/*')

p Dir['b/*']
