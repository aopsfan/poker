class InputView
  
  def get_input(receiver, prompt)
    puts "\n(#{receiver}) #{prompt}"
    print "> "
    response = gets
    print "\n"
    
    response
  end
  
end