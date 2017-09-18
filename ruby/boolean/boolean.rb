# encoding: UTF-8
require_relative '../colorize/colorize'

a = [
  nil,
  false,
  true,
  0,
  1,
  '',
  '0',
  '1',
  {},
  [],
  [nil],
  [0],
  [1],
  [''],
  ['0'],
  ['1']
]

b = ['nil?','empty?']

a.each do |v|
  if v.nil?
    print "#{'nil'.rjust(5).blue}"
  else
    print "#{v.to_s.rjust(5).blue}"
  end
  print " #{v.class.name.ljust(10)} —   " 
  b.each do |f|
    begin
      print "#{f} #{v.send(f).to_s.ljust(5).send((v.send(f))? 'green' : 'red')},"
    rescue => e
      print "#{f} #{'error'.yellow},"
    end
    print "   "
  end
  print "!#{v.to_s.ljust(5)} #{ (!v).to_s.ljust(5).send( (!v) ? 'green' : 'red')} "
  print "!!#{v.to_s.ljust(6)} #{ (!!v).to_s.ljust(5).send( (!!v) ? 'green' : 'red')} "
  print "\n"
end

print '"aaa" == "aaa" ',                        "aaa" == "aaa",                      "\n"
print '"aaa" === "aaa" ',                       "aaa" === "aaa",                     "\n"
print '"aaa".object_id === "aaa".object_id ',   "aaa".object_id === "aaa".object_id, "\n"
print ':aaa === :aaa ',                         :aaa === :aaa,                       "\n"
print '"aaa".eql? "aaa" ',                      "aaa".eql?("aaa"),                    "\n"
print '"aaa".equal? "aaa" ',                    "aaa".equal?("aaa"),                  "\n"
print ':aaa.eql? :aaa ',                        :aaa.eql?(:aaa),                      "\n"
print ':aaa.equal? :aaa ',                      :aaa.equal?(:aaa),                    "\n"
# puts :aaa.class

