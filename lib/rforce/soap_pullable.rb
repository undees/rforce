require 'facets/openhash'

module RForce
  module SoapPullable
    SOAP_ENVELOPE = 'soapenv:Envelope'

    # Split off the local name portion of an XML tag.
    def local(tag)
      first, second = tag.split ':'
      return first if second.nil?
      @namespaces.include?(first) ? second : tag
    end

    def tag_start(name, attrs)
      # For shorter hash keys, we can strip any namespaces of the SOAP
      # envelope tag from the tags inside it.
      if name == SOAP_ENVELOPE
        @namespaces = attrs.keys.grep(/xmlns:/).map {|k| k.split(':').last}
        return
      end

      @stack.push OpenHash.new({})
    end

    def text(data)
      adding = data.strip.empty? ? nil : data

      if adding
        @current_value = (@current_value || '') + adding
      end
    end

    def tag_end(name)
      return if @done || name == SOAP_ENVELOPE

      tag_name = local name
      working_hash = @stack.pop

      # We are either done or working on a certain depth in the current
      # stack.
      if @stack.empty?
        @parsed = working_hash
        @done = true
        return
      end

      index = @stack.size - 1

      # working_hash and @current_value have a mutually exclusive relationship.
      # If the current element doesn't have a value then it means that there
      # is a nested data structure.  In this case then working_hash is populated
      # and @current_value is nil.  Conversely, if @current_value has a value
      # then we do not have a nested data structure and working_hash will
      # be empty.
      raise 'Parser is confused' unless working_hash.empty? || @current_value.nil?

      use_value = working_hash.empty? ? @current_value : working_hash
      tag_sym = tag_name.to_sym
      element = @stack[index][tag_sym]

      if @stack[index].keys.include? tag_sym
        # This is here to handle the Id value being included twice and thus
        # producing an array.  We skip the second instance so the array is
        # not created.
        #
        # We also need to clear out the current value, so that the next
        # tag doesn't erroneously pick up the value of the Id.
        if tag_name == 'Id'
          @current_value = nil
          return
        end

        # We are here because the name of our current element is one that
        # already exists in the hash.  If this is the first encounter with
        # the duplicate tag_name then we convert the existing value to an
        # array otherwise we push the value we are working with and add it
        # to the existing array.
        if element.is_a?( Array )
          element << use_value
        else
          @stack[index][tag_sym] = [element, use_value]
        end
      else
        # We are here because the name of our current element has not been
        # assigned yet.
        @stack[index][tag_sym] = use_value
      end

      # We are done with the current tag so reset the data for the next one
      @current_value = nil
    end
  end
end
