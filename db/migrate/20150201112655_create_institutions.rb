class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name,           null: false
      t.string :street_address, null: false
      t.string :city,           null: false
      t.string :state
      t.string :postalcode
      t.string :country,        null: false

      t.timestamps
    end
  end
end
