# frozen_string_literal: true

# class Game.
class Game
  def initialize(file_path)
    @file_path = file_path
    @serialized_text_file = SerializeTextFileService.new(@file_path).call
    @rows = @serialized_text_file.call[:rows]
    @columns = @serialized_text_file.call[:columns]
    @generation_number = @serialized_text_file.call[:generation_number]
    @grid = @serialized_text_file.call[:grid]
  end

  def next_generation_number
    @generation_number + 1
  end

  def next_generation_grid
    grid = @grid.map do |row|
      
    end
    grid
  end
end
