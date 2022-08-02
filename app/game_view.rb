# frozen_string_literal: true

# class GameView
class GameView
  def display_generations(game)
    puts '------------ Current Generation -----------'
    puts game.generation_text(game.generation_number, game.rows, game.columns, game.grid)
    puts '------------ Next Generation --------------'
    puts game.generation_text(game.next_generation_number, game.rows, game.columns, game.next_generation_grid)
  end
end
