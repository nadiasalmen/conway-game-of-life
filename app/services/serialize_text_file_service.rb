# frozen_string_literal: true

# class SerializeTextFileService
class SerializeTextFileService
  def initialize(file_path)
    @file_path = file_path
    @text = File.read(@file_path)
  end

  def call
    return validations_errors unless validations_errors.empty?

    {
      generation_number: generation_number,
      rows: rows,
      columns: columns,
      grid: grid
    }
  end

  private

  def validation_errors
    errors = []
    errors << 'File is empty' if empty_file?
    errors << 'File format is not valid' unless valid_text_format?
    errors << 'Number of rows does not match input grid' if grid.nil?
    errors
  end

  def empty_file?
    @text.empty?
  end

  def valid_text_format?
    @file_path.match?(/\.txt$/)
  end

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
    return if text_to_array[2..].count != rows

    grid = []
    text_to_array[2..].each do |row|
      grid << row.split('').map do |cell|
        Cell.new(cell == '*')
      end
    end
    grid
  end
end
