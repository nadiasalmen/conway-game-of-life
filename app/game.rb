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
        if i.zero?
          if j.zero?
            sum += @grid[i][j + 1].value + @grid[i + 1][j].value + @grid[i + 1][j + 1].value
          elsif j == @columns - 1
            sum += @grid[i][j - 1].value + @grid[i + 1][j].value + @grid[i + 1][j - 1].value
          else
            sum += @grid[i][j - 1].value + @grid[i][j + 1].value + @grid[i + 1][j].value + @grid[i + 1][j - 1].value + @grid[i + 1][j + 1].value
          end
        elsif i == @rows - 1
          if j.zero?
            sum += @grid[i - 1][j].value + @grid[i - 1][j + 1].value + @grid[i][j + 1].value
          elsif j == @columns - 1
            sum += @grid[i - 1][j].value + @grid[i - 1][j - 1].value + @grid[i][j - 1].value
          else
            sum += @grid[i - 1][j - 1].value + @grid[i - 1][j].value + @grid[i - 1][j + 1].value + @grid[i][j - 1].value + @grid[i][j + 1].value + @grid[i][j - 1].value
          end
        else
          if j.zero?
            sum += @grid[i - 1][j].value + @grid[i - 1][j + 1].value + @grid[i][j + 1].value + @grid[i + 1][j + 1].value
          elsif j == @columns - 1
            sum += @grid[i - 1][j].value + @grid[i - 1][j - 1].value + @grid[i][j - 1].value + @grid[i + 1][j - 1].value
          else
            sum += @grid[i - 1][j - 1].value + @grid[i - 1][j].value + @grid[i - 1][j + 1].value + @grid[i][j - 1].value + @grid[i][j + 1].value + @grid[i + 1][j - 1].value + @grid[i + 1][j].value + @grid[i + 1][j + 1].value
          end
        end
        grid[i] ||= []
        grid[i][j] = if sum == 3 || (sum == 2 && cell.alive?)
                       Cell.new(cell.live)
                     else
                       Cell.new(cell.die)
                     end
      end
    end
    grid
  end

  def next_generation_text
    "Generation #{next_generation_number}:\n#{@rows} #{@columns}\n" +
      next_generation_grid.map { |row| row.map { |cell| cell.value == 1 ? '*' : '.' }.join('') }.join("\n")
  end
end
