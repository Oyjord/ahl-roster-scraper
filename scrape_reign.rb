require 'ahl_scraper'
require 'json'
require 'date'  # ✅ For parsing birthdates

team_id = 403  # Ontario Reign
season_id = 89 # Current Regular Season

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
    headshot: player.headshot # ✅ Add this line if AhlScraper exposes it
  }
end

File.write("reign_roster.json", JSON.pretty_generate(players))
puts "✅ Roster saved to reign_roster.json"
