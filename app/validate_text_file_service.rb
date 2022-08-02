# frozen_string_literal: true

# class ValidateTextFileService
class ValidateTextFileService
  def initialize(file_path)
    @file_path = file_path
    @text = File.read(@file_path)
  end

  def call
    errors = []
    errors << 'File is empty' if empty_file?
    errors << 'File format is not valid' unless valid_text_format?
    return errors if errors.any?

    errors << 'Number of rows does not match input grid' unless rows_match_grid?
    errors << 'Number of columns does not match input grid or some columns are incomplete' unless columns_match_grid?
    errors
  end

  private

  def empty_file?
    @text == ''
  end

  def valid_text_format?
    @file_path.match?(/\.txt$/)
  end

  def text_to_array
    @text.split("\n")
  end

  def rows
    text_to_array[1]&.split(' ')&.first&.to_i
  end

  def columns
    text_to_array[1]&.split(' ')&.last&.to_i
  end

  def rows_match_grid?
    text_to_array[2..].count == rows
  end

  def columns_match_grid?
    text_to_array[2..].each do |row|
      return false unless row.split('').count == columns
    end
    true
  end
end
