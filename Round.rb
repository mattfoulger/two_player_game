class Round
  
  attr_accessor :players, :current_player_index
  attr_reader :round_count, :type

  def initialize(players, type, round_count)
    @round_count = round_count
    @type = type
    @players = players
    # randomize who gets to go first this round
    @current_player_index = rand(0..(players.count - 1))
    # set up the round
    players.each do |player|
      player.score = 0
      player.lives = 3
    end
  end

  # this method is called by the turn loop to see if the round is still on
  def playing?
    players.select{|player| player.lives > 0}.count > 1
  end

  def turn_loop
    # turn loop, calls a turn then moves to the next player
    while playing? do
      turn(players[@current_player_index], type)
      unless @current_player_index == players.count - 1
        @current_player_index += 1
      else
        @current_player_index = 0
      end
    end
  end

  def turn(player, type)
    return unless player.lives > 0
    round_score
    puts "#{player.name}, it's your turn!"
    
    case type
    when "Math"
      QuestionMath.new(player)
    when "Geography"
      QuestionGeo.new(player)
    end
  end

  # take care of scorekeeping and end of round messaging
  def round_end
    # evaluate winner and add to his/her win count
    winner = players.detect{|player| player.lives > 0}
    winner.wins += 1

    # round end score and message
    puts "------------------ROUND OVER------------------".yellow
    puts "  #{winner.name}" + " won Round #{round_count} with #{winner.score} points!"
    puts "----------------------------------------------".yellow
    puts ""
    puts "Current Scores:"
    scoreboard
    puts "----------------------------------------------".yellow

    # end the round
    puts "Press any key to continue or 'q' to end game"
    response = gets.chomp.downcase
    response == "q"
  end

  def round_header(type, round_count)
    puts ""
    puts "------------------ROUND #{@round_count}---------------------".yellow
    if type == "Math"
      puts "                   #{type}".yellow
    else
      puts "                 #{type}".yellow
    end
    puts ""
    puts "#{players[@current_player_index].name} gets to go first this round."
    puts "----------------------------------------------".yellow
  end

  class << self

    def create(players, type, round_count)
      round = Round.new(players, type, round_count)
      round.round_header(type, round_count)
      round.turn_loop
      round
    end
  end

end