# frozen_string_literal: true

# class Cell.
class Cell
  def initialize(alive)
    @alive = alive
  end

  def alive?
    @alive
  end

  def value
    @alive ? 1 : 0
  end

  def live
    @alive = true
  end

  def die
    @alive = false
  end
end
