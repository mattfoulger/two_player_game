class Round
  
  def initialize(players, type)
    @type = type
    @players = players
    #randomize who gets to go first this round
    @current_player_index = rand(0..(@players.count - 1))

    # @round_type = type
    # set up the round
    @players.each do |player|
      player.score = 0
      player.lives = 3
    end
    binding.byebug
    puts ""
    puts "------------------ROUND #{@round_count}---------------------".yellow
    puts "#{@players[@current_player_index].name} gets to go first this round."
    puts "----------------------------------------------".yellow
  end

  # this method is called by the turn loop to see if the round is still on
  def playing?
    @players.select{|player| player.lives > 0}.count > 1
  end

  def turn_loop
    # turn loop, calls a turn then moves to the next player
    while playing? do
      turn(@players[@current_player_index], @type)
      unless @current_player_index == @players.count - 1
        @current_player_index += 1
      else
        @current_player_index = 0
      end
    end
  end

  # take care of scorekeeping and end of round messaging
  def round_end
    # evaluate winner and add to his/her win count
    winner = @players.detect{|player| player.lives > 0}
    winner.wins += 1 

    # round end score and message
    puts "------------------ROUND OVER------------------".yellow
    puts "  #{winner.name}" + " won Round #{@round_count} with #{winner.score} points!"
    puts "----------------------------------------------".yellow
    puts ""
    puts "Current Scores:"
    scoreboard
    puts "----------------------------------------------".yellow

    # end the round
    puts "Would you like to play another round? Y/N"
    response = gets.chomp.downcase
    response == "n"
  end

end