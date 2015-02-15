class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string  :position,    null: false
      t.string  :phone,       null: false
      t.string  :email,       null: false
      t.string  :first_name,  null: false
      t.string  :last_name,   null: false
      t.json    :properties,  null: false, default: {}
      t.integer :assigned_to

      t.timestamps
    end
  end
end
