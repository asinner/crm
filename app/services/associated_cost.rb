class AssociatedCost
  def self.with(product_id, estimate)
    line_items = []
    costs(product_id).each do |cost|
      line_items.push(find_or_initialize(estimate, cost))
    end    
    line_items
  end
  
  def self.costs(product_id)
    Product.find(params[:product_id]).costs
  end
  
  def self.find_or_intialize(estimate, cost)
    item = estimate.items.find_or_initialize_by(
      name: cost.name,
      description: cost.description,
      amount: cost.amount,
      role: 'expense'
    )
    item.qty = (item.qty ||= 0) + cost.qty
  end
end