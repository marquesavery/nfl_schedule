class NflSchedule::Schedule

  def self.current_week
    puts "Sunday, September 20"
    puts "  1. New York at Chicago at 12:00pm, Soldier Field, Chicago"
    puts "  2. Atlanta at Dallas at 12:00pm, AT&T Stadium, Arlington"

    game_1.team1 = "New York"
    game_1.team2 = "Chicago"
    game_1.time = "12:00pm"
    game_1.location = "Soldier Field, Chicago"
  end

end
