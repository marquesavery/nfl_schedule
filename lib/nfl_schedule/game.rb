class NflSchedule::Game
  attr_accessor :team1, :team2, :time, :location, :url, :day, :result

  @@all = []  #class variable to store instances of a game

  def self.all #Method to return the list of game instances
    @@all
  end

  def self.games(url) # Scrapes espn (url) from the NFLSchedule::CLI.schedule method
    scrape_results = NflSchedule::Scraper.scrape_espn(url)
    teams = scrape_results[0]
    days = scrape_results[1]
    results = scrape_results[2]
    locations = scrape_results[3]
    urls = scrape_results[4]
    counter = 0
    @@all = []

    teams.each_slice(2) do |team| #creates instance of game and assigns variables
      new_game = self.new
      new_game.team1 = team[0]
      new_game.team2 = team[1]
      new_game.result = results[counter]
      new_game.location = locations[counter]
      new_game.url = urls[counter]
      if counter == 0
        new_game.day = days[0]
      elsif counter == 1
        new_game.day = days[1]
      elsif counter == 15
        new_game.day = days[2]
      end
      counter += 1
      @@all << new_game
    end
    @@all
  end

end
