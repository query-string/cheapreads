class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :key, nill: false
      t.string :secret, null: false

      t.timestamps
    end
  end
end
