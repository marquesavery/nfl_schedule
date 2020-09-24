class NflSchedule::Schedule
  attr_accessor :team1, :team2, :time, :location, :url, :day, :result

  @@games = []

  def self.all
    @@games
  end

  def self.scrape_espn(url)
    doc = Nokogiri::HTML(open(url))
    @@games = []
    teams = []
    days = []
    results = []
    locations = []
    urls = []
    counter = 0

    doc.css(".team-name span").each do |team|
      teams << team.text
    end

    doc.css(".table-caption").each do |day|
      days << day.text
    end

    doc.css("a[name='&lpos=nfl:schedule:score']").each do |final|
      results << final.text
    end

    doc.css(".schedule-location").each do |location|
      locations << location.text
    end

    doc.css("a[name='&lpos=nfl:schedule:time']/@href").each do |url|
      urls << url.text
    end

    teams.each_slice(2) do |team|
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

  def self.scrape_game(url)
    doc = Nokogiri::HTML(open(url.prepend("https://www.espn.com")))
    odds = []

    odds << doc.css(".score")[5].text #Team1 Spread
    odds << doc.css(".score")[10].text #Team2 Spread
    odds << doc.css(".score")[6].text.gsub("\n",'').gsub("\t",'') #Team1 Money line
    odds << doc.css(".score")[11].text.gsub("\n",'').gsub("\t",'') #Team2 Money line
    odds << doc.css(".score")[7].text #over/under

    odds
  end

end
