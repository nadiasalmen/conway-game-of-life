# frozen_string_literal: true

# class Router
class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    while @running
      display_tasks
      print '> '
      action = STDIN.gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.show_next_generation
    when 2 then stop
    else
      puts '-------------------------------------------'
      puts 'Please, 1 or 2.'
      puts '-------------------------------------------'
      print '> '
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts '-------------------------------------------'
    puts '1 - Show next generation'
    puts '2 - Stop and exit the program'
    puts '-------------------------------------------'
  end
end
