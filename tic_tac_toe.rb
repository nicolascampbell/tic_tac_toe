require_relative 'position';require_relative'player';require_relative'score';require_relative'board'
class Game

  #getter and setter for player in case needed to be change the symbol
  attr_accessor :player1, :player2

  #Constructor with default size, creates board initialize free fields and last move
  def initialize(size=3,value1,value2)
    @player1=Player.new(value1)
    @player2=Player.new(value2)
    @board=Board.new(size)
    @free_fields=size*size
    @last_move=nil
  end

  #method to make move and with validation
  private def move(pos, player)
    if  @free_fields.to_i>0 && @board.valid_change?(pos,player)
      @board.set_board(pos, player)
      @free_fields-=1
      @last_move=pos
    else
      raise "enter a valid Position"
    end
  end
  
  #Checks if game is won
  private def won?()
    #if the amount of total free spaces is bigger than size*2-1 then its imposible to have a winner
    if((@board.size**2-@free_fields)<(2*@board.size-1))
      return false
    end
    #To check less stuff we check first if the move was made in a spot that is only possible to win trough rows or cols
    if((@last_move.x.to_i+@last_move.y.to_i)!=(@board.size.to_i-1) &&(@last_move.x.to_i-@last_move.y.to_i)!=0)
      return spaltenZeilenPrufer()
    else
    #Otherwise we check both
      return diagonalePrufer()||spaltenZeilenPrufer()
    end
  end

  #checks ife the game was won with diagonal 
  private def diagonalePrufer()
    a=true;
    b=true;
    c=true;
    d=true;
    i=0;
    while i<@board.size.to_i && (a||b||c||d) do
      if((@board.get_field(@last_move)!=@board.get_board[i][i]) && a)
          a=false
      end
      if (@board.get_field(@last_move)!=@board.get_board[@board.size.to_i-1-i][i] && b)
          b=false
      end
      if (@board.get_field(@last_move)!=@board.get_board[@board.size.to_i-1-i][@board.size.to_i-1-i] && c)
          c=false
      end
      if(@board.get_field(@last_move)!=@board.get_board[@board.size.to_i-1-i][i] && d)
          d=false
      end
      i+=1
    end
    return a||b||c||d
  end

  #checks ife the game was won with col or rows
  private def spaltenZeilenPrufer()
    cols=true
    rows=true
    i=0
    while i<@board.size && (cols||rows) 
      if(@board.get_field(@last_move)!=@board.get_board[i][@last_move.x.to_i] && cols)
          cols=false;
      end
      if(@board.get_field(@last_move)!=@board.get_board[@last_move.y.to_i][i] && rows)
          rows=false;
      end
      i+=1;
    end
    return rows||cols;
  end

  private def is_numeric?(obj) 
    obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end
  #used to generalize asking user for data input, also it validates data to see if its a number. If its not a number checks again 
  private def ask_user(player)
    begin
      puts "Please insert column player: #{player.value}"
      x=gets
    end while !is_numeric?(x)
    begin
      puts "Please insert row player: #{player.value}"
      y=gets
    end while !is_numeric?(y)
    return Position.new(x,y)
  end

  def play
    @board.print_board
    #description
    puts "So, each player will make one move at a time! How they express which move they want is by writing first the column, hit enter and then the row coordinate and hit enter."
    #game
    while !won? && @free_fields>0
      puts @free_fields
      begin
        move(ask_user(player1),player1)
      rescue
        puts "Enter a valid Position from 0 to #{@board.size}"
        retry
      end
      @board.print_board
      if won? || @free_fields==0; break end;
      begin
        move(ask_user(player2),player2)
      rescue
        puts "Enter a valid Position from 0 to #{@board.size}"
        retry
      end
      @board.print_board
    end
    #checking if it was a tie or a defeat and for who it is. Also updates scores
    if @free_fields==0 && !won?
      player1.update_score(0)
      player2.update_score(0)
      puts "Its a tie"
    else
      winner=@board.get_player_from_cell(@last_move,@player1,@player2)
      if(winner.equal?(player1))
        player1.update_score(1)
        puts "Player1 Wins!!"
        player2.update_score(-1)
      elsif(winner.equal?(player2))
        player1.update_score(-1)
        puts "Player2 Wins!!"
        player2.update_score(1)
      end
    end
  end
end
tic=Game.new(4,"x","o")
tic.play






      

