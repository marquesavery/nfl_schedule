class NflSchedule::CLI
  def call
    schedule
    menu
    goodbye
  end

  def schedule
    puts "This week's Schedule."
    puts "Sunday, September 20"
    puts "  1. New York at Chicago at 12:00pm"
    puts "  2. Atlanta at Dallas at 12:00pm"
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the game you'd like more info, type list for the full schedule, or type exit to leave:"
      input = gets.strip.downcase
      if input.to_i == 1
        puts "More info on game one"
      elsif input.to_i == 2
        puts "More info on game two"
      elsif input == "list"
        schedule
      else
        puts "Not sure what you want, type list or exit:"
      end
    end
  end

  def goodbye
    puts "Enjoy watching the NFL!"
  end

end
