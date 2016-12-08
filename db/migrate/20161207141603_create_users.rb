class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :email_id, unique: true, null: false
    	t.string :name
    	t.boolean :activated
      t.timestamps null: false
    end
  end
end