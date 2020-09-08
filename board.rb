class Board
  attr_reader :size
  def initialize(size=3)
    @size=size
    @board=create_board()
  end
  private def create_board()
    return Array.new(@size) {Array.new(@size) {"-"} }
  end
  def print_board
    for i in 0...@board.length
      for j in 0...@board.length
        print @board[i][j]
      end
      puts ""
    end
  end
#checks if the assigned pos for that player is valid
  def valid_change?(position,player)
    if (position.y.to_i>=0&&position.x.to_i>=0&&position.y.to_i<@size.to_i&&position.x.to_i<@size.to_i) && (@board[position.y.to_i][position.x.to_i]=="-")
      true
    else
      false
    end
  end
#sets a position for a player
  def set_board(position,player)
    if (valid_change?(position,player))
      @board[position.y.to_i][position.x.to_i]=player.value
    else
      raise "Position was not within bounds!"
    end
  end
  def get_board
    return @board
  end
  #gets the token of the player in a position
  def get_field(pos)
    @board[pos.y.to_i][pos.x.to_i]
  end
  #gets the player itself from a position
  def get_player_from_cell(pos,player1,player2)
    p=@board[pos.y.to_i][pos.x.to_i]
    if (p!="-")
      if(p==player1.value)
        return player1
      else
        return player2
      end
    end
  end

end