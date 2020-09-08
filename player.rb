class Player
  attr_reader :value, :score
  def initialize(value)
    @value=value
    @score=Score.new()
  end
  # 1 is for win, 0 for tie, -1 is for loss
  def update_score(score)
    if score>0
      @score.wins+=1
    elsif score==0
      @score.ties+=1
    elsif score<0
      @score.losses+=1
    else
      raise "InputMismatchExeption" 
    end
  end
end