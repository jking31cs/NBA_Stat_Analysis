require_relative 'weightForm.rb'

totalSum = 1

def generateForm()
  weights = (0..6).map { |x| rand }
  curSum = weights.inject(:+)
  weights.to_a.map! { |x| x/curSum }
  createForm(weights)
end

def generateForms(numOfTeams)
  (1..numOfTeams).to_a.map! { generateForm() }
end
