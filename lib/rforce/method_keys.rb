module RForce
  # Allows indexing hashes like method calls: hash.key
  # to supplement the traditional way of indexing: hash[key]
  module MethodKeys
    def respond_to_missing?(*)
      return true if respond_to?(:[])
      super
    end

    def method_missing(method, *args)
      return self[method] if respond_to?(:[])
      super
    end
  end

  class MethodHash < Hash
    include MethodKeys
  end
end
