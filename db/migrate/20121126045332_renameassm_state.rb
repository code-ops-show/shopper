class RenameassmState < ActiveRecord::Migration
  def change
    rename_column :orders, :assm_state, :state
  end
end
