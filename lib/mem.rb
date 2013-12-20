require "mem/version"

module Mem
  def memoize(method_name)
    define_method("#{method_name}_with_memoize") do |*args, &block|
      @__memo ||= {}
      @__memo[method_name] ||= send("#{method_name}_without_memoize", *args, &block)
    end
    alias_method "#{method_name}_without_memoize", method_name
    alias_method method_name, "#{method_name}_with_memoize"
  end
end
