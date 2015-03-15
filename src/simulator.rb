require 'mongo'
require 'date'

class Simulator
  def initialize()
    @conn = Mongo::Connection.new
    @db = @conn['nbaDb']
    @gameStats = @db['gameStats']

    @teamSimulationResults = @db['teamSimulationResults']
  end

  def compareTeams(team1, team2, startDate)

    team1_score = team1[:team].map { |p| getPlayerScore(p, startDate) } .inject(:+)

    team2_score = team2[:team].map { |p| getPlayerScore(p, startDate) } .inject(:+)

    if (team1_score > team2_score)
      return 1
    elsif (team1_score < team2_score)
      return -1
    else
      return 0
    end
  end

  def getPlayerScore(p, startDate)
    player = p[:player]
    games = @gameStats.find("Player_ID" => player['playerId']).to_a

    games.select! do |g|
      endDate = startDate + 7
      gameDate = Date.parse(g["GAME_DATE"])
      gameDate >= startDate && gameDate < endDate
    end
    
    pscore = games.map do |g|
      sum = 0
      sum += g["PTS"].to_i
      sum += 0.5 * g["FG3M"].to_i
      sum += 1.25 * g["REB"].to_i
      sum += 1.5 * g["AST"].to_i
      sum += 2 * g["STL"].to_i
      sum += 2 * g["BLK"].to_i
      sum -= 0.5 * g["TOV"].to_i
      #Possibly check for DD or TD here
    end .inject(:+)

    if (pscore == nil)
      pscore = 0
    end

    return pscore
  end

end
