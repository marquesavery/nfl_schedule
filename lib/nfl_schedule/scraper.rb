class NflSchedule::Scraper

#   def self.scrape_schedule
#     doc = Nokogiri::HTML(open("https://www.espn.com/nfl/schedule"))
#     doc.css('.schedule tr').drop(1).each do |row|
#       binding.pry
#       away_team = row.css(".team-name span")[0].text 
#       home_team = row.css(".team-name span")[1].text
#       puts "#{away_team} at #{home_team}"
#     #   row.css(":nth-child(3)").attribute("data-date").value
#     end      
#   end

    def self.scrape_espn(url) # Scrapes espn (url) from the NFLSchedule::CLI.schedule method
        doc = Nokogiri::HTML(open(url))
        teams = [] #lists will store info for each iteration of parsing
        days = []
        results = []
        locations = []
        urls = []
    
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
        
        scrape_results = [teams, days, results, locations, urls]
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
