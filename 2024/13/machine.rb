class Machine
  attr_reader :a, :b, :prize, :cost_a, :cost_b
  attr_accessor :memo

  def initialize(a:, b:, prize:, cost_a:, cost_b:)
    @a = a
    @b = b
    @prize = prize
    @cost_a = cost_a
    @cost_b = cost_b
    # Store seen x,y pairs with minimum cost and number each token used: { cost: , a: , b: }
    # Abandon this dynamic programming over engineering thing. Lets do simple linear algebra.
    @memo = {}
  end

  def ax = a[0]
  def ay = a[1]
  def bx = b[0]
  def by = b[1]
  def prizex = prize[0]
  def prizey = prize[1]

  # Math, linear algebra, 2 equations, 2 unknowns: prize_a = A * ax + B * bx, prize_b = A * ay + B * by
  def solve
    const_a = (1.0 * by * prizex - prizey * bx) / (1.0 * ax * by - ay * bx)
    const_b = (1.0 * prizey - const_a * ay) / (1.0 * by)

    [const_a, const_b]
  end

  def increase_prize(n)
    @prize = [prizex + n, prizey + n]
    self
  end

  def x_or_y_over_prize?(x, y)
    x >= prizex || y >= prizey
  end

  def x_or_y_under_prize?(x, y)
    x <= prizex || y <= prizey
  end

  def cost(token)
    token == :a ? cost_a : cost_b
  end

  def won?
    memo[[0, 0]]
  end

  def less_expensive_token
    avgs = [a, b].map do |token|
      xtimes = prizex / token[0]
      ytimes = prizey / token[1]
      (xtimes + ytimes) / 2.0
    end

    (avgs[0] * cost_a) < (avgs[1] * cost_b) ? :a : :b
  end
end
