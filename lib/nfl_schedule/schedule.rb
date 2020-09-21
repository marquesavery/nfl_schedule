class NflSchedule::Schedule
  attr_accessor :team1, :team2, :time, :location, :url

  def self.current_week
    NflSchedule::ScheduleScraper.new("https://www.espn.com/nfl/schedule")


    game_1 = self.new
    game_1.team1 = "New York"
    game_1.team2 = "Chicago"
    game_1.time = "12:00pm"
    game_1.location = "Soldier Field, Chicago"
    game_1.url = "https://www.espn.com/nfl/game/_/gameId/401220281"

    game_2 = self.new
    game_2.team1 = "Atlanta"
    game_2.team2 = "Dallas"
    game_2.time = "12:00pm"
    game_2.location = "AT&T Stadium, Arlington"
    game_2.url = "https://www.espn.com/nfl/game/_/gameId/401220249"

    [game_1, game_2]
  end

end
