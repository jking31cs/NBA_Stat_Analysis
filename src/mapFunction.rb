require_relative 'weightForm'

def map(player, form)
  sum = 0
  sum += player["pts"] * form.pointWeight
  sum += player["fg3m"] * form.threePointWeight
  sum += player["reb"] * form.reboundWeight
  sum += player["ast"] * form.assistWeight
  sum += player["stl"] * form.stealWeight
  sum += player["blk"] * form.blockWeight
  sum -= player["tov"] * form.turnoverWeight

   return sum
 end
