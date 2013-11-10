class Guest < User
  def move_to user
    addresses.update_all(user_id: user.id) #move to user exists
    self.destroy
  end

  def set_default_to address
    addresses.where("id != ?", address.id).default.update_all(default: false)
    address.update_attributes(default: true)
  end

  def to_member
    self.name = name_from_email
    self.type = "Member"
  end
end