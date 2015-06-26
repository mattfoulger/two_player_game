require 'byebug'
require 'colorize'

require_relative 'Player'
require_relative 'game_initialize'
require_relative 'question'
require_relative 'geo_capitals'
require_relative 'round_score'
require_relative 'round_initialize'
require_relative 'round_end'
require_relative 'game_end'
require_relative 'leaders'


game_initialize

@no_more = false

# this method is called by the turn loop to see if the round is still on
def playing?
  @players.select{|player| player.lives > 0}.count > 1
end

def round
  # set up the round
  round_initialize

  # turn loop, calls a turn then moves to the next player
  while playing? do
    turn(@current_player_index)
    unless @current_player_index == @player_count - 1
      @current_player_index += 1
    else
      @current_player_index = 0
    end
  end

  # take care of scorekeeping and end of round messaging
  round_end

  # end the round
  puts "Would you like to play another round? Y/N"
  response = gets.chomp.downcase
  if response == "n"
    @no_more = true
  end

end

def turn(player_index)
  @current_player = @players[player_index]
  return unless @current_player.lives > 0
  round_score
  puts "#{@current_player.name}, it's your turn!"
  question
end

# game loop
while(true) 
  round
  break if @no_more == true
end

game_end

 



