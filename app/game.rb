# frozen_string_literal: true

require_relative 'serialize_text_file_service'

# class Game.
class Game
  attr_reader :grid, :generation_number, :rows, :columns

  def initialize
    @file_path = 'lib/initial_generation.txt'
    @serialized_text_file = SerializeTextFileService.new(@file_path)
    @rows = @serialized_text_file.call[:rows]
    @columns = @serialized_text_file.call[:columns]
    @generation_number = @serialized_text_file.call[:generation_number]
    @grid = @serialized_text_file.call[:grid]
  end

  def next_generation_number
    @generation_number + 1
  end

  def next_generation_grid
    grid = []
    @grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        sum = 0
        neighbours(i, j).each do |h, w|
          sum += @grid[h][w].alive? ? 1 : 0
        end
        grid = cell_evolution(grid, cell, i, j, sum)
      end
    end
    grid
  end

  def generation_text(generation_number, rows, columns, grid)
    "Generation #{generation_number}:\n#{rows} #{columns}\n" +
      grid.map { |row| row.map { |cell| cell.value == 1 ? '*' : '.' }.join('') }.join("\n")
  end

  private

  def cell_evolution(grid, cell, i, j, sum)
    grid[i] ||= []
    grid[i][j] = if sum == 3 || (sum == 2 && cell.alive?)
                   Cell.new(true)
                 else
                   Cell.new(false)
                 end
    grid
  end

  def neighbours(i, j)
    neighbours = [
      [i, j - 1],
      [i, j + 1],
      [i - 1, j - 1],
      [i - 1, j],
      [i - 1, j + 1],
      [i + 1, j - 1],
      [i + 1, j],
      [i + 1, j + 1]
    ]
    neighbours.select do |h, w|
      h.between?(0, @rows - 1) && w.between?(0, @columns - 1)
    end
  end
end
