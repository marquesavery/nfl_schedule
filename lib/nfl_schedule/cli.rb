class NflSchedule::CLI
  def call
    schedule
    menu
  end

  def schedule(url = "https://www.espn.com/nfl/schedule")

    puts "This week's Schedule."
    @schedule = NflSchedule::Schedule.scrape_espn(url)
    @schedule.each.with_index(1) do |game, i|
      if game.day != nil
        puts "#{game.day}"
      end
      puts "  #{i}. #{game.team1} at #{game.team2} #{game.result}, #{game.location}."
    end
  end

  def menu
    input = nil
    while input != "exit"
      puts "Enter the number of the game you'd like more info, type list for the full schedule, or type exit to leave:"
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i <= 16
        the_game = @schedule[input.to_i-1]
        puts "#{the_game.team1} at #{the_game.team2}, #{the_game.location}."
        odds = NflSchedule::Schedule.scrape_game(the_game.url)
        puts "Spread"
        puts "#{odds[0]}      #{odds[1]}"
        puts "Money Line"
        puts "#{odds[2]}    #{odds[3]}"
        puts "Over/Under"
        puts "#{odds[4]}"
      elsif input == "list"
        schedule
      elsif input == "exit"
        goodbye
      else
        puts "Not sure what you want, type list or exit:"
      end
    end
  end

  def goodbye
    puts "Enjoy watching the NFL!"
  end

end
