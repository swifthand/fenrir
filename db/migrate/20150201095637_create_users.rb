class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :first_name,              null: false
      t.string  :last_name,               null: false
      t.string  :email,                   null: false
      t.boolean :admin,   default: false, null: false
      t.boolean :active,  default: true,  null: false

      t.timestamps
    end
  end
end