class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.integer  :owner_id, null: false
      t.string :plan, null:false
      t.timestamps
    end
  end
end
