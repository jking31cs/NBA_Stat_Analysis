require_relative 'weightForm'

def map(player, form)
  sum = 0
  sum += player["pts"] * form['pts']
  sum += player["fg3m"] * form['fg3m']
  sum += player["reb"] * form['reb']
  sum += player["ast"] * form['ast']
  sum += player["stl"] * form['stl']
  sum += player["blk"] * form['blk']
  sum -= player["tov"] * form['tov']

  return sum
end
