require "mem/version"

module Mem
  def memoize(method_name)
    is_called = false
    memo = nil

    define_method("#{method_name}_with_memoize") do |*args, &block|
      if is_called
        memo
      else
        is_called = true
        memo = send("#{method_name}_without_memoize", *args, &block)
      end
    end

    alias_method "#{method_name}_without_memoize", method_name
    alias_method method_name, "#{method_name}_with_memoize"
  end
end
