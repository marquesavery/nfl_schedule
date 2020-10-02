class NflSchedule::CLI
  def call
    schedule
    menu
  end

  def schedule(url = "https://www.espn.com/nfl/schedule") #list the NFL Schedule

    puts "This week's Schedule."
    @schedule = NflSchedule::Game.games(url) #calls the scrape method from the schedule class
    @schedule.each.with_index(1) do |game, i| #iterates through the games array and lists the games
      if game.day != nil
        puts "#{game.day}"
      end
      puts "  #{i}. #{game.team1} at #{game.team2} #{game.result}, #{game.location}."
    end
  end

  def menu #lists options for user
    input = nil
    while input != "exit" #continues until the user is done
      puts "Enter the number of the game you'd like more info, type list for the full schedule, or type exit to leave:"
      input = gets.strip.downcase

      if input.to_i > 0 && input.to_i <= 16 #Max of 16 games a week (32 teams)
        the_game = @schedule[input.to_i-1] #calls and assigns the game to a variable
        puts "#{the_game.team1} at #{the_game.team2}, #{the_game.location}."
        odds = NflSchedule::Scraper.scrape_game(the_game.url) #scrapes the specific game called and lists the odds
        puts "Spread"
        puts "#{odds[0]}      #{odds[1]}"
        puts "Money Line"
        puts "#{odds[2]}    #{odds[3]}"
        puts "Over/Under"
        puts "#{odds[4]}"
      elsif input == "list" #if user input is list it will show the schedule again
        schedule
      elsif input == "exit" #will cause the application to stop
        goodbye
      else
        puts "Not sure what you want, type list or exit:" #lets user know the input is invalid
      end
    end
  end

  def goodbye #shows user the application is closing
    puts "Enjoy watching the NFL!"
  end

end
