class AddColumnInGrouptable < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :grp_members, :text, array: true, default: []
  end
end
