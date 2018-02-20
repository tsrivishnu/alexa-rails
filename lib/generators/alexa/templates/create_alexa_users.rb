class CreateAlexaUsers < ActiveRecord::Migration[4.2]
  def up
    create_table :alexa_users do |t|
      t.string :amazon_id
    end
    add_index :alexa_users, :amazon_id
  end

  def down
    remove_index :alexa_users, :amazon_id
    drop_table :alexa_users
  end
end
