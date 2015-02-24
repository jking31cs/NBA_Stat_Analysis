class WeightForm

  attr_reader :pointWeight
  attr_reader :threePointWeight
  attr_reader :reboundWeight
  attr_reader :assistWeight
  attr_reader :stealWeight
  attr_reader :blockWeight
  attr_reader :turnoverWeight
  attr_reader :ddWeight
  attr_reader :tdWeight
  
  def initialize(pointWeight, threePointWeight, reboundWeight, assistWeight, stealWeight, blockWeight, turnoverWeight, ddWeight, tdWeight)
    @pointWeight = pointWeight
    @threePointWeight = threePointWeight
    @reboundWeight = reboundWeight
    @assistWeight = assistWeight
    @stealWeight = stealWeight
    @blockWeight = blockWeight
    @turnoverWeight = turnoverWeight
    @ddWeight = ddWeight
    @tdWeight = tdWeight
  end
end


def defaultWeight()
 WeightForm.new(1, 0.5, 1.25, 1.5, 2, 2, -0.5, 1.5, 3)
end
