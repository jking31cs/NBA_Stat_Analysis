class WeightForm

  attr_reader :pointWeight
  attr_reader :threePointWeight
  attr_reader :reboundWeight
  attr_reader :assistWeight
  attr_reader :stealWeight
  attr_reader :blockWeight
  attr_reader :turnoverWeight
    
  def initialize(pointWeight, threePointWeight, reboundWeight, assistWeight, stealWeight, blockWeight, turnoverWeight)
    @pointWeight = pointWeight
    @threePointWeight = threePointWeight
    @reboundWeight = reboundWeight
    @assistWeight = assistWeight
    @stealWeight = stealWeight
    @blockWeight = blockWeight
    @turnoverWeight = turnoverWeight
  end
end


def defaultWeight()
 WeightForm.new(1, 0.5, 1.25, 1.5, 2, 2, 0.5)
end

def createForm(weights)
  WeightForm.new(weights[0], weights[1], weights[2], weights[3], weights[4], weights[5], weights[6])
end
