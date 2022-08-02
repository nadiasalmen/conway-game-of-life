# frozen_string_literal: true

require_relative 'cell'

# class SerializeTextFileService
class SerializeTextFileService
  def initialize(file_path)
    @file_path = file_path
    @text = File.read(@file_path)
  end

  def call
    {
      generation_number: generation_number,
      rows: rows,
      columns: columns,
      grid: grid
    }
  end

  private

  def text_to_array
    @text.split("\n")
  end

  def generation_number
    text_to_array&.first&.split(' ')&.last&.to_i
  end

  def rows
    text_to_array[1]&.split(' ')&.first&.to_i
  end

  def columns
    text_to_array[1]&.split(' ')&.last&.to_i
  end

  def grid
    grid = []
    text_to_array[2..].each_with_index do |row, i|
      row.split('').each_with_index do |cell, j|
        grid[i] ||= []
        grid[i][j] = Cell.new(cell == '*')
      end
    end
    grid
  end
end
