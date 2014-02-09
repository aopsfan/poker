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
  
  def print
    puts "\n==========\n#{@title}"
    @key_value_hash.each do |key, value|
      puts "#{key}: #{value}"
    end
    puts "==========\n\n"
  end
  
end