# = OrderedHash
#
# == Version
#  1.2005.08.16 (change of the first number means Big Change)
#
# == Description
#  Hash which preserves order of added items (like PHP array).
#
# == Usage
#  Require orderedhash.rb and use OrderedHash instead of Hash (examples are at the end).
#  You can try to run orderedhash.rb.
#
#  Example:
#
#   hsh = OrderedHash.new
#   hsh['z'] = 1
#   hsh['a'] = 2
#   hsh['c'] = 3
#   p hsh.keys     # ['z','a','c']
#    
# == Tip
#  See OrderedAutoHash (cool!)
#
# == Source
# http://simplypowerful.1984.cz/orderedhash/1.2005.08.16
#
# == Author
#  jan molic (/mig/at_sign/1984/dot/cz/)
#
# == Thanks to
#  Andrew Johnson for his suggestions and fixes of Hash[], merge, to_a, inspect and shift
#  Desmond Dsouza for == fixes
#
# == Licence
#  You can redistribute it and/or modify it under the same terms of Ruby's license;
#  either the dual license version in 2003, or any later version.
#


class OrderedHash < Hash

    attr_accessor :order

    class << self
	def [] *args
	    hsh = OrderedHash.new
	    if Hash === args[0]
		hsh.replace args[0]
	    elsif (args.size % 2) != 0
		raise ArgumentError, "odd number of elements for Hash"
	    else
		hsh[args.shift] = args.shift while args.size > 0
	    end
	    hsh
	end
    end

    def initialize(*a, &b)
	super
	@order = []
    end
    
    def store_only a,b
	store a,b
    end
    
    alias orig_store store    
    def store a,b
	@order.push a unless has_key? a
	super a,b
    end
    alias []= store
    
    def == hsh2
	return hsh2==self if !hsh2.is_a?(OrderedHash) 
        return false if @order != hsh2.order
	super hsh2
    end
    
    def clear
	@order = []
	super
    end
    
    def delete key
	@order.delete key
	super
    end
    
    def each_key
	@order.each { |k| yield k }
	self
    end
    
    def each_value
	@order.each { |k| yield self[k] }
	self
    end
    
    def each
	@order.each { |k| yield k,self[k] }
	self
    end
    alias each_pair each    

    def delete_if
	@order.clone.each { |k| 
	    delete k if yield
	}
	self
    end
    
    def values
	ary = []
	@order.each { |k| ary.push self[k] }
	ary
    end
    
    def keys
	@order
    end
    
    def invert
	hsh2 = Hash.new    
	@order.each { |k| hsh2[self[k]] = k }
	hsh2
    end
    
    def reject &block
	self.dup.delete_if &block
    end
    
    def reject! &block
	hsh2 = reject &block
	self == hsh2 ? nil : hsh2
    end

    def replace hsh2
	@order = hsh2.keys 
	super hsh2
    end
    
    def shift
	key = @order.first
	key ? [key,delete(key)] : super
    end

    def unshift k,v
	unless self.include? k
	    @order.unshift k
	    orig_store(k,v)
	    true
	else
	    false
	end
    end
    
    def push k,v
	unless self.include? k
	    @order.push k
	    orig_store(k,v)
	    true
	else
	    false
	end
    end
    
    def pop
	key = @order.last
	key ? [key,delete(key)] : nil
    end
    
    def first
	self[@order.first]
    end
    
    def last
    	self[@order.last]
    end
    
    def to_a
	ary = []
	each { |k,v| ary << [k,v] }
	ary
    end
    
    def to_s
	self.to_a.to_s
    end
    
    def inspect
	ary = []
	each {|k,v| ary << k.inspect + "=>" + v.inspect}
	'{' + ary.join(", ") + '}'
    end
    
    def update hsh2
	hsh2.each { |k,v| self[k] = v }
	self
    end
    alias :merge! update
    
    def merge hsh2
	self.dup update(hsh2)
    end
    
    def select
	ary = []
	each { |k,v| ary << [k,v] if yield k,v }
	ary
    end
    
end

#=end

if __FILE__ == $0

    # You can do simply
    hsh = OrderedHash.new
    hsh['z'] = 1
    hsh['a'] = 2
    hsh['c'] = 3
    p hsh.keys     # ['z','a','c']

    # or using OrderedHash[] method
    hsh = OrderedHash['z', 1, 'a', 2, 'c', 3] 
    p hsh.keys     # ['z','a','c']

    # but this don't preserve order
    hsh = OrderedHash['z'=>1, 'a'=>2, 'c'=>3]
    p hsh.keys     # ['a','c','z']

    # OrderedHash has useful extensions: push, pop and unshift
    p hsh.push('to_end', 15)  # true, key added
    p hsh.push('to_end', 30)  # false, already - nothing happen
    p hsh.unshift('to_begin', 50)  # true, key added
    p hsh.unshift('to_begin', 60)  # false, already - nothing happen
    p hsh.keys     # ["to_begin", "a", "c", "z", "to_end"]
    p hsh.pop      # ["to_end", 15], if nothing remains, return nil
    p hsh.keys     # ["to_begin", "a", "c", "z"]
    p hsh.shift    # ["to_begin", 30], if nothing remains, return nil
    
    # and first, last
    p hsh.first    # 2
    p hsh.last	   # 1
    
    # if you want to extend normal Hash, just put somewhere
    # class Hash < OrderedHash; end

end


# END
