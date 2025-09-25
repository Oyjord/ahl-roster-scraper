require 'ahl_scraper'
require 'json'

# Ontario Reign team ID: 369
# Use a recent season ID—let's fetch the latest regular season
season = AhlScraper::Seasons.list.find { |s| s.name.include?("Regular") }

unless season
  puts "❌ No regular season found"
  exit 1
end

team_id = 369
season_id = season.id

puts "🔍 Scraping Ontario Reign roster for season #{season.name} (ID: #{season_id})"

players = AhlScraper::RosterPlayers.retrieve_all(team_id, season_id).map do |player|
  {
    full_name: player.name,
    position: player.position,
    birth_year: player.birthdate&.year,
    jersey_number: player.jersey_number,
    profile_url: "https://theahl.com/player/#{player.id}"
  }
end

File.write("reign_roster.json", JSON.pretty_generate(players))
puts "✅ Roster saved to reign_roster.json"
