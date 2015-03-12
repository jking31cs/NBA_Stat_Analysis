require 'mongo'
require_relative 'mapFunction'


class TeamMaker
  def initialize()
    @conn = Mongo::Connection.new
    @db = @conn['nbaDb']
    @players = @db['nba_players']
  end

  def makeTeam(form)
    mapping = @players.find().map { |p| {:player => p, :score => map(p, form)} }
    mapping.sort_by! { |e| e[:score] } .reverse!
    
    guards = mapping.find_all {  |p| p[:player]['position'].upcase.include?("GUARD") }
    forwards = mapping.find_all { |p| p[:player]['position'].upcase.include?("FORWARD") }
    centers = mapping.find_all { |p| p[:player]['position'].upcase.include?("CENTER") }

    toptwoguards = [guards[0], guards[1]]
    toptwoforwards= [forwards[0], forwards[1]]
    topcenter = [centers[0]]

    toptwoguards.concat(toptwoforwards).concat(topcenter)
  end
end


