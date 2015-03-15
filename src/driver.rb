require_relative 'formGenerator'
require_relative 'teamMaker'
require_relative 'simulator'
require 'mongo'
require 'date'

class Driver

  def initialize()
    @conn = Mongo::Connection.new
    @db = @conn['nbaDb']
    @teamResults = @db['teamResults']
    @teamForms = @db['teamForms']
  end
  
  def drive()
    teams = generateForms(100)
    teams.each { |f| @teamForms.insert(f) }
    teamMaker = TeamMaker.new

    teams.map! { |f| {:form => @teamForms.find(f).to_a[0], :team => teamMaker.makeTeam(f)} }

    matchups = teams.combination(2)
    curMatchup = 1
    totalMatchups = matchups.size()
    matchups.each do |m|
      sim = Simulator.new
      startDate = Date.parse("OCT 28, 2014")
      curWeek = 1
      while (startDate.to_datetime < Date.today.to_datetime)
        result = sim.compareTeams(m[0], m[1], startDate)
        resultRow = { "t1" => m[0], "t2" => m[1], "result" => result, "weekNum" => curWeek }
        
        @teamResults.insert(resultRow)
        startDate = startDate + 7
        curWeek += 1
      end
      puts 'Finished ' + curMatchup.to_s + ' of ' + totalMatchups.to_s
      curMatchup += 1
    end
  end
end

driver = Driver.new
driver.drive()
