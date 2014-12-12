class LineItemDeduplicator
  def self.find_or_initialize(estimate, items)
    results = []
    items.each do |i|   
      item = estimate.items.where(
        name: i[:name],
        amount: self.get_amount(i, true),
        description: i[:description]
      ).first_or_initialize(
        name: i[:name],
        description: i[:description],
        amount: self.get_amount(i, false),
        role: i[:role] || 'expense'
      )
      item.qty += i[:qty]
      results << item      
    end
    results
  end
    
  def self.get_amount(item, transform)
    amount = item.class == Cost ? item.amount : item[:amount]
    amount *= 100 if transform
    amount
  end
end