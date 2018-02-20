class CreateAlexaUsages < ActiveRecord::Migration[4.2]
  def up
    create_table :alexa_usages do |t|
      t.references :alexa_user, foreign_key: true
      t.string :intent_name
      t.integer :count, default: 0
    end
  end

  def down
    drop_table :alexa_usages
  end
end
