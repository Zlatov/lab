#!/usr/bin/env ruby
# require 'rubygems'
require "test/unit"
require "awesome_print"
require_relative "test_class"

puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"

class TestTestClass < Test::Unit::TestCase

  def test_class_exist
    assert ::TestClass
  end

  def test_sum
    assert_equal 4, TestClass.sum(2,2)
  end

  def test_aserts
    # Проверяет результат выполнения блока
    assert_block do
      [1,2,3].any? do |var|
        var < 10
      end
    end
    assert_equal 4, 4
    assert_no_match /a[xc]+/, 'asd', 'регулярка не должна находить'
    assert_not_equal 2, 3, 'не должны быть равны'
    assert_not_nil 0, 'не должно быть nil'
    assert_not_send [[1, 2], :member?, 4], 'выполнение send на первом элементе не дожно давать третий элемент'
    assert_not_same "x", "x", "должен быть не тем же самым"
    assert_nothing_raised RuntimeError do
      # Не работает какого-то хера
      raise Exception #Assertion passes, Exception is not a RuntimeError
    end
    assert_nothing_raised do
      # raise Exception #Assertion fails
    end
  end
end

# require "minitest/autorun"

# class TestMeme < Minitest::Test
#   # def setup
#   #   @meme = Meme.new
#   # end

#   def test_that_kitty_can_eat
#     assert_equal 4, TestClass.sum(2,2)
#     assert_equal "OHAI!", @meme.i_can_has_cheezburger?
#   end

#   # def test_that_it_will_not_blend
#   #   refute_match /^no/i, @meme.will_it_blend?
#   # end

#   # def test_that_will_be_skipped
#   #   skip "test this later"
#   # end
# end
