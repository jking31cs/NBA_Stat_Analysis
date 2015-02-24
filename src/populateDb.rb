require 'json'
require 'bson'
require 'mongo'
include Mongo

target_json_directory = ARGV[0]
Dir.chdir(target_json_directory)

mongo_client = MongoClient.new("localhost", 27017)
db = mongo_client.db('nbaDb')

players = db.collection('nba_players')

Dir.foreach(target_json_directory) do |f|
  puts f
  file = File.new(f, 'r')
  if (File.file?(file) && File.fnmatch('*.json', f))
    playerInfo = JSON.load(file)
    stats = playerInfo['resultSets'][0]
    player = {}
    player[:name] = f.chomp('.json')
    player[:playerId] = playerInfo['parameters']['PlayerID']
    player[:position] = playerInfo['playerPosition']
    if (!stats['rowSet'].empty?)
      values = stats['rowSet'][0]
      player[:fgm] = values[7]
      player[:fga] = values[8]
      player[:fg3m] = values[10]
      player[:fg3a] = values[11]
      player[:ftm] = values[13]
      player[:fta] = values[14]
      player[:oreb] = values[16]
      player[:dreb] = values[17]
      player[:reb] = values[18]
      player[:ast] = values[19]
      player[:tov] = values[20]
      player[:stl] = values[21]
      player[:blk] = values[22]
      player[:pts] = values[26]

      players.insert(player)
    end
  end

end
 
