ActiveAdmin.register Order do
  index do
    column :id
    column :state
    default_actions
  end
end