require 'ahl_scraper'
require 'json'
require 'date'

team_id = 403  # Ontario Reign
season_id = 90 # current Regular Season

players = AhlScraper::RosterPlayers.retrieve_all(team_id, season_id).map do |player|
  birth_year = begin
    Date.parse(player.birthdate).year
  rescue
    nil
  end

  {
    full_name: player.name,
    position: player.position,
    birth_year: birth_year,
    jersey_number: player.jersey_number,
    profile_url: "https://theahl.com/player/#{player.id}",
    headshot: "https://assets.leaguestat.com/ahl/240x240/#{player.id}.jpg" # ✅ build URL
  }
end

File.write("reign_roster.json", JSON.pretty_generate(players))
puts "✅ Roster saved to reign_roster.json"
