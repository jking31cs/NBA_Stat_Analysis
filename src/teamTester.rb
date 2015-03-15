require 'rubygems'
require 'bundler/setup'
require_relative 'formGenerator'
require_relative 'teamMaker'
require_relative 'simulator'
require 'mongo'
require 'date'

class TestDriver

  def initialize()
    @conn = Mongo::Connection.new
    @db = @conn['nbaDb']
  end
  
  def drive()
    myTeamForm = { "pts" => 0.15, "fg3m" => 0.175, "ast" => 0.025, "stl" => 0.125, "blk" => 0.125, "reb" => 0.225, "tov" => 0.175 }
    teams = generateForms(50)
    teamMaker = TeamMaker.new

    teams.map! { |f| {:team =>teamMaker.makeTeam(f)} }
    myTeam = {:team => teamMaker.makeTeam(myTeamForm)}
    wins = 0;
    losses = 0;
    ties = 0;
    teams.each do |t|
      sim = Simulator.new
      startDate = Date.parse("OCT 28, 2014")
      curWeek = 1
      while (startDate.to_datetime < Date.today.to_datetime)
        result = sim.compareTeams(myTeam, t, startDate)
        if (result == 1)
          wins += 1
        elsif (result == -1)
          losses += 1
        else
          ties += 1
        end
          startDate = startDate + 7
          curWeek += 1
      end      
    end
    puts ("Total Wins: " + wins.to_s)
    puts ("Total Losses: " + losses.to_s)
    puts ("Total ties: " + ties.to_s)
  end
end

driver = TestDriver.new
driver.drive()
