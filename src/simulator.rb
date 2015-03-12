require 'mongo'

class Simulator
  def initialize()
    @conn = Mongo::Connection.new
    @db = @conn['nbaDb']
    @gameStats = @db['gameStats']

    @teamSimulationResults = @db['teamSimulationResults']
  end

  def compareTeams(team1, team2)
    startDate = Date.parse('OCT 28, 2014')

    while startDate < Date.new
      team1[:team].each do |p|
        games = gameStats.find({'Player_ID' => p['playerId']})
        games.select! do |g|
          endDate = startDate + 7
          gameDate = Date.parse(g["GAME_DATE"])
          gameDate >= startDate && gameDate < endDate
        end
        puts games
      end

      startDate = Date.new
      
    end
  end

end
