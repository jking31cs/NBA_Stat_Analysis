require_relative 'formGenerator'
require_relative 'teamMaker'
require 'mongo'

class Driver
  def drive()
    teams = generateForms(100)
    teamMaker = TeamMaker.new

    teams.map! { |f| {:form => f, :team => teamMaker.makeTeam(f)} }

    teams.each { |t| puts t }
  end
end

driver = Driver.new
driver.drive()
