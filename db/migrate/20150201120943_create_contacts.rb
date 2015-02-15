class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.integer :lead_id
      t.text    :description
      t.string  :status
      t.string  :occurred_at

      t.timestamps
    end
  end
end
