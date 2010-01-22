gem 'builder'
require 'rforce'

include RForce

module RForceXmlMatchers
  class Resemble
    def initialize(expected)
      @expected = expected
    end

    def matches?(actual)
      @actual = actual

      return false if different 'size',
        @actual.size,
        @expected.size

      @expected.each_with_index do |exp_rec, index|
        act_rec = @actual[index]
        
        # Only bother to look at the first <Id>
        # tag in a (presumably) duplicated set.
        act_id = first_id(act_rec[:Id])
        exp_id = first_id(exp_rec[:Id])
        
        return false if different '<Id>', act_id, exp_id
        return false if different 'keys', act_rec.keys, exp_rec.keys

        exp_rec.each do |key, _|
          unless key == :Id
            return false if different key, act_rec[key], exp_rec[key]
          end
        end
      end

      return true
    end

    def failure_message_for_should
      %Q{expected "#{@actual.to_s[0..9]}..." } +
        %Q{to resemble "#{@expected.to_s[0..9]}...":\n} +
        @difference
    end

    private

    def first_id(id)
      id.is_a?(Array) ? id.first : id
    end

    def different(name, act, exp)
      return nil if act == exp
      @difference = %Q{  for #{name}, got:\n     } +
        %Q{#{act.inspect}\n  expected:\n     #{exp.inspect}}
    end
  end

  def resemble(expected)
    Resemble.new(expected)
  end
end

Spec::Runner.configure do |config|
  config.include(RForceXmlMatchers)
end
