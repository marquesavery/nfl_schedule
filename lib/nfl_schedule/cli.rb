class NflSchedule::CLI
  def call
    schedule
    menu
    goodbye
  end

  def schedule
    puts "This week's Schedule."
    @schedule = NflSchedule::Schedule.current_week
    @schedule.each.with_index(1) do |game, i|
      puts "#{i}. #{game.team1} at #{game.team2} at #{game.time}, #{game.location}."
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the game you'd like more info, type list for the full schedule, or type exit to leave:"
      input = gets.strip.downcase

      if input.to_i > 0
        the_game = @schedule[input.to_i-1]
        puts "#{the_game.team1} at #{the_game.team2} at #{the_game.time}, #{the_game.location}."
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
