class KeyValueView
  
  def initialize(title)
    @title = title
    @key_value_hash = Hash.new
  end
  
  def method_missing(method, *args, &block)
    method_name = method.to_s
    if method_name[-1, 1] == "=" # count backward one from the end of the string, then return a string of length 1
      method_name.chop!
      formatted_method = method_name.gsub!("_", " ")
      formatted_method = method_name unless formatted_method
      formatted_method.capitalize!
      @key_value_hash[method_name] = args.first
    else
      super
    end
  end
  
  def to_s
    separator = "=========="
    body = @key_value_hash.inject("") do |memo, array|
      "#{memo}#{array[0]}: #{array[1]}\n"
    end
    
    ["\n", separator, @title, body, separator, "\n"].join("\n")
  end
  
end