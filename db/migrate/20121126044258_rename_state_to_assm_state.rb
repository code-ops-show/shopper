class RenameStateToAssmState < ActiveRecord::Migration
  def change
    rename_column :orders, :state, :assm_state
  end
end
