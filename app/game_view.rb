# frozen_string_literal: true

# class GameView
class GameView
  def display_generations(game)
    puts '------------ Current Generation -----------'
    write_generation(game, game.generation_number, game.grid)
    puts '------------ Next Generation --------------'
    write_generation(game, game.next_generation_number, game.next_generation_grid)
  end

  private

  def write_generation(game, generation_number, grid)
    puts "Generation #{generation_number}:"
    puts "#{game.rows} #{game.columns}"
    puts grid.map { |row| row.map { |cell| cell.value == 1 ? '*' : '.' }.join('') }.join("\n")
  end
end
