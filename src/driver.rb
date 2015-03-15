require 'rubygems'
require 'bundler/setup'
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
    teams = generateForms(250)
    teams.each { |f| @teamForms.insert(f) }
    teamMaker = TeamMaker.new

    teams.map! { |f| {:form => @teamForms.find(f).to_a[0], :team => teamMaker.makeTeam(f)} }
    
    matchups = Queue.new
    teams.combination(2).each { |m| matchups.push(m) }
    totalMatchups = matchups.size
    workers = (0...4).map do
      Thread.new do
        begin
          while m = matchups.pop(true)
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
            puts 'Finished ' + (totalMatchups - matchups.size).to_s + ' of ' + totalMatchups.to_s
          end
        rescue
          ThreadError
        end
      end
    end; "Ok"
    workers.map(&:join); "Ok"
  end
   
end

driver = Driver.new
driver.drive()
