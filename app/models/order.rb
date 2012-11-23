class Order < ActiveRecord::Base

  def self.purchased
    this.update_attributes(type: 'Purchase')
  end
end