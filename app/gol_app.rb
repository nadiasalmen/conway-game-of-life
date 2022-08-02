# frozen_string_literal: true

require_relative 'game_controller'
require_relative 'validate_text_file_service'

path_to_file = ARGV[0]
validation_errors = ValidateTextFileService.new(path_to_file).call

unless validation_errors.empty?
  puts 'Your file is invalid. Please, check the following errors:'
  validation_errors.each do |error|
    puts "- #{error}"
  end
  puts '-------------------------------------------'
  puts 'Please, try again. Your .txt file should match the following format:'
  puts '-------------------------------------------'
  puts 'Generation 5:
  4 8
  ........
  ...**...
  ...**...
  ........'
  puts '-------------------------------------------'
  puts 'Exiting...'
  exit
end

puts '-------------------------------------------'
puts 'Welcome to the Game of Life!'
puts '-------------------------------------------'

File.open('lib/initial_generation.txt', 'w') do |file|
  file.write(File.read(path_to_file))
end

controller = GameController.new
controller.show_next_generation
