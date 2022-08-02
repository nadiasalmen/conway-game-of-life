# frozen_string_literal: true

require_relative 'game_view'
require_relative 'game'
require_relative 'router'

# class GameController
class GameController
  def initialize
    @view = GameView.new
    @router = Router.new(self)
  end

  def show_next_generation
    game = Game.new
    @view.display_generations(game)
    File.open('lib/initial_generation.txt', 'w') do |file|
      file.write(game.generation_text(game.next_generation_number, game.rows, game.columns, game.next_generation_grid))
      file.close
    end
    @router.run
  end
end
