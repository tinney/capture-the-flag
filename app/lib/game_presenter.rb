class GamePresenter
  def initialize(game)
  end

  def each_row
    yield [0,1,1,1]
    yield [0,1,2,1]
    yield [0,1,1,1]
    yield [1,1,1,1]
  end
end