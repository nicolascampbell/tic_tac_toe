class Position
  attr_accessor :x, :y
  def initialize(x,y)
    @x=x
    @y=y
  end
  def to_s
    "x: ".concat(@x).concat("y: ").concat(@y)
  end
end