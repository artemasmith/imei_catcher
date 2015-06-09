class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :location
      t.string :sim
      t.integer :manager
      t.boolean :supported
      t.date :warranty_end
      t.string :imei

      t.timestamps
    end
  end
end
