# frozen_string_literal: true

# class Router
class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    puts "Welcome to the Game of Life!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.input_initial_generation
    when 2 then @controller.next_generation
    when 3 then stop
    else
      puts "Please press 1, 2, 3"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "1 - Input initial generation"
    puts "2 - Next generation"
    puts "3 - Stop and exit the program"
    puts ""
  end
end
