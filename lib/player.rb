class Player
  attr_accessor :name 

  def initialize(name) 
    @name = name
  end

  def move(board, position, engine) 
    board.positions_with_values[position] = self.name
    board.display
    winner = engine.check_winner(board)
    if winner != "No One"
      engine.display_winner(self.name)
    end
  end

  def best_move(board, engine) 
    puts ""
    puts "Robot (O player) is taking turn..."

    sleep 2

    position = check_priority(board)

    board.positions_with_values["#{position}"] = "O"

    winner = engine.check_winner(board)

    if winner != "No One"
      puts ""
      board.display
      engine.display_winner(self.name)
    end

    puts ""
    board.display
  end
