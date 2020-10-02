class NflSchedule::Games
  attr_accessor :team1, :team2, :time, :location, :url, :day, :result

  @@all = []  #class variable to store instances of a game

  def self.all #Method to return the list of game instances
    @@all
  end

  def self.game(url) # Scrapes espn (url) from the NFLSchedule::CLI.schedule method
    scrape_results = NflSchedule::Scraper.scrape_espn(url)
    teams = scrape_results[0]
    days = scrape_results[1]
    results = scrape_results[2]
    locations = scrape_results[3]
    urls = scrape_results[4]
    counter = 0
    @@all = []

    teams.each_slice(2) do |team| #creates instance of game and assigns variables
      game = self.new
      game.team1 = team[0]
      game.team2 = team[1]
      game.result = results[counter]
      game.location = locations[counter]
      game.url = urls[counter]
      if counter == 0
        game.day = days[0]
      elsif counter == 1
        game.day = days[1]
      elsif counter == 15
        game.day = days[2]
      end
      counter += 1
      @@all << game
    end
    @@all
  end

end
