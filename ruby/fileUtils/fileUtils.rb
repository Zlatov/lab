require 'rubygems'
require 'fileutils'

FileUtils.mv Dir['a/*'], 'b'
FileUtils.mv Dir['b/*'], 'a'

p Dir['a/*']