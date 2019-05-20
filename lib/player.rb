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


private

  def check_priority(board) 
    flag = true

    x_name = "X"
    o_name = "O"

    o_position = position_priority(board, o_name) 

    if !o_position.nil?
      return o_position
    end

    x_position = position_priority(board, x_name)

    if !x_position.nil?
      return x_position
    end

    while flag do
      random_position = 1 + rand(8)
      if board.positions_with_values["#{random_position}"] != "X" and board.positions_with_values["#{random_position}"] != "O"
        board.positions_with_values["#{random_position}"] = "O"
        return random_position
        flag false
      end
    end
  end

  def position_priority(board, mark)
    Board::WINNING_PLACES.each do |winning_place|
      priority_positions_order = [[0, 1, 2], [0, 2, 1], [1, 2, 0]]
      priority_positions_order.each do |priority|
        if (board.positions_with_values["#{winning_place[priority[0]]}"] == mark) and (board.positions_with_values["#{winning_place[priority[1]]}"] == name)
          if board.positions_with_values["#{winning_place[priority[2]]}"] == " "
            return winning_place[priority[2]]
          end
        end
      end
    end
    return nil
  end
end 
