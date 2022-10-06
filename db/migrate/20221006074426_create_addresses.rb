class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.belongs_to :user
      t.string :Street
      t.string :city
      t.string :state
      t.timestamps
    end
  end
end
