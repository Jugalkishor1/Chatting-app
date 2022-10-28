class AddcolumnInGrouptable < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :g_name, :string
  end
end
