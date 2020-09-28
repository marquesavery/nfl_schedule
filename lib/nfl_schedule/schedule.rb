class NflSchedule::Schedule
  attr_accessor :team1, :team2, :time, :location, :url, :day, :result

  @@games = []  #class variable to store instances of a game

  def self.all #Method to return the list of game instances
    @@games
  end

  def self.scrape_espn(url) # Scrapes espn (url) from the NFLSchedule::CLI.schedule method
    doc = Nokogiri::HTML(open(url))
    @@games = []
    teams = [] #lists will store info for each iteration of parsing
    days = []
    results = []
    locations = []
    urls = []
    counter = 0

    doc.css(".team-name span").each do |team| #parses teams and pushes to array
      teams << team.text
    end

    doc.css(".table-caption").each do |day| #parses the day they are playing and pushes to array
      days << day.text
    end

    doc.css("a[name='&lpos=nfl:schedule:score']").each do |final|#parses the results of the game pushes to array
      results << final.text
    end

    doc.css(".schedule-location").each do |location|#parses the location of the game and pushes to array
      locations << location.text
    end

    doc.css("a[name='&lpos=nfl:schedule:time']/@href").each do |url| #parses the games url and pushes to array
      urls << url.text
    end

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
      @@games << game
    end
    @@games
  end

  def self.scrape_game(url) #scrapes the specific game using the instances url
    doc = Nokogiri::HTML(open(url.prepend("https://www.espn.com"))) #the url in the site doesn't have the begining
                                                                    #of the url so had to add here
    odds = [] #store the betting information in the odds array

    odds << doc.css(".score")[5].text #Team1 Spread
    odds << doc.css(".score")[10].text #Team2 Spread
    odds << doc.css(".score")[6].text.gsub("\n",'').gsub("\t",'') #Team1 Money line
    odds << doc.css(".score")[11].text.gsub("\n",'').gsub("\t",'') #Team2 Money line
    odds << doc.css(".score")[7].text #over/under

    odds
  end

end
