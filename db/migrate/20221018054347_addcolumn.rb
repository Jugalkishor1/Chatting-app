class Addcolumn < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :type, :string
  end
end
