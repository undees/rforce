require 'xml/parser'


module RForce
  class SoapResponseExpat
    include FlashHash

    attr_reader :hash_time

    SOAP_ENVELOPE = 'soapenv:Envelope'

    def initialize(content)
      @current_value, @stack, @parsed = nil, [], Hash.new
      
      namespaces = []
      t = Time.now
      
      XML::Parser.new.parse( content ) do |type, name, data|
        # We are not interested in keeping the namespace declarations for the tag
        # names so lets deal with that here.
        unless name.nil?
          if name.index( ':' )
            tag_ns, tag_name = name.split( ':' )
            tag_name = name unless namespaces.include?( tag_ns )
          else
            tag_name = name
          end
        end

        case type
          # name     = The literal tag name of the element
          # tag_name = The name of the element minus the namespace that gets used
          #            as the key in the hash 
          # data     = The attributes of the element
          when XML::Parser::START_ELEM
            # The attribute of the first element is the soap envelope which has
            # as attributes the allowed namespaces of all the tags so lets grab
            # them here to make sure we can strip them out appropriately since
            # they are not necessary in our hash.
            namespaces = data.keys.map { |k| k.split( ':' )[1] if k.match( 'xmlns:' ) }.compact if name.eql?( SOAP_ENVELOPE )
            
            next if tag_name.eql?( SOAP_ENVELOPE )
            
            @stack.push( Hash.new )
            
          # name     = The literal tag name of the element
          # tag_name = The name of the element minus the namespace that gets used
          #            as the key in the hash 
          # data     = The actual data identified by the element
          when XML::Parser::CDATA
            @current_value = data.strip.empty? ? nil : data
            
          # name     = The literal tag name of the element
          # tag_name = The name of the element minus the namespace that gets used
          #            as the key in the hash 
          # data     = nil
          when XML::Parser::END_ELEM
            next if tag_name.eql?( SOAP_ENVELOPE )

            working_hash = @stack.pop

            # We are either done or working on a certain depth in the current
            # stack.
            if @stack.empty?
              @parsed = working_hash
              break
            else
              index = @stack.size - 1
            end

            # working_hash and @current_value have a mutually exclusive relationship.
            # If the current element doesn't have a value then it means that there
            # is a nested data structure.  In this case then working_hash is populated
            # and @current_value is nil.  Conversely, if @current_value has a value
            # then we do not have a nested data sctructure and working_hash will
            # be empty.
            use_value = ( working_hash.empty? ) ? @current_value : working_hash

            if @stack[index].keys.include?( tag_name.to_sym )
              # This is here to handle the Id value being included twice and thus
              # producing an array.  We skip the second instance so the array is
              # not created.
              if tag_name.eql?( 'Id' )
                # If we don't clear out the current value here, then we introduce
                # a bug if the element after this Id should be null.  An example
                # query is the following:
                #
                # Select Id, LeadId, ContactId from CampaignMember...
                #
                # For the members that are Contacts their LeadId will be null.  If
                # we fail to clear out this data the resulting hash would be:
                #
                # { ... :records => [ 
                #   { :Id => '00v50000008pfHrAAI', :LeadId => '00v50000008pfHrAAI', :ContactId => '0035000000KwjIuAAJ' },
                #   { :Id => '00v50000008pfHsAAI', :LeadId => '00v50000008pfHsAAI', :ContactId => '0035000000KwjIvAAJ' },
                # }
                #
                # Now you see the problem.  When the @current_value = nil is present
                # we get the following:
                #
                # { ... :records => [ 
                #   { :Id => '00v50000008pfHrAAI', :LeadId => nil, :ContactId => '0035000000KwjIuAAJ' },
                #   { :Id => '00v50000008pfHsAAI', :LeadId => nil, :ContactId => '0035000000KwjIvAAJ' },
                # }
                #
                # which is correct so don't get the bright idea of removing this
                # line
                @current_value = nil
                next
              end

              # We are here because the name of our current element is one that
              # already exists in the hash.  If this is the first encounter with
              # the duplicate tag_name then we convert the existing value to an
              # array otherwise we push the value we are working with and add it
              # to the existing array.
              if @stack[index][tag_name.to_sym].is_a?( Array )
                @stack[index][tag_name.to_sym] << use_value
              else
                @stack[index][tag_name.to_sym] = [ @stack[index][tag_name.to_sym] ]
                @stack[index][tag_name.to_sym] << use_value
              end
            else
              # We are here because the name of our current element has not been
              # assigned yet.
              @stack[index][tag_name.to_sym] = use_value
            end

            # We are done with the current tag so reset the data for the next one
            @current_value = nil
        end
      end

      @hash_time = Time.now - t

      self
    end

    def [](key)
      @parsed[key.to_sym]
    end
  end
end
