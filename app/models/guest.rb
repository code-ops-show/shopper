class Guest < User  
  def move_to user
    addresses.update_all(user_id: user.id) #move to user exists
    self.destroy
  end

  def set_default_to address
    addresses.default.update_all(default: false)
    address.update_attribute :default, true
  end
end