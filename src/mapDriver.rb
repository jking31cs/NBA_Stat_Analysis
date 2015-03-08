require 'mongo'
require_relative 'weightForm'
require_relative 'mapFunction'

conn = Mongo::Connection.new
db   = conn['nbaDb']
players = db["nba_players"]

mapping = players.find().map do |player|
  { :player => player, :score => map(player, defaultWeight()) }
end

mapping.sort_by! { |e| e[:score] }.reverse!

guards = mapping.find_all {  |p| p[:player]['position'].upcase.include?("GUARD") }
forwards = mapping.find_all { |p| p[:player]['position'].upcase.include?("FORWARD") }
centers = mapping.find_all { |p| p[:player]['position'].upcase.include?("CENTER") }

toptwoguards = [guards[0], guards[1]]
toptwoforwards= [forwards[0], forwards[1]]
topcenter = [centers[0]]

puts toptwoguards.concat(toptwoforwards).concat(topcenter)
