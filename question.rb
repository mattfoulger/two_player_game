def question 

  question_generator
  response = gets.chomp

  if response == @answer 
    @current_player[:score] += 5
    puts "CORRECT!".green + " #{@current_player[:name]} just earned 5 points."
  else
    @current_player[:lives] -= 1
    puts "WRONG!".red + " #{@current_player[:name]} just lost a life."
  end

end
