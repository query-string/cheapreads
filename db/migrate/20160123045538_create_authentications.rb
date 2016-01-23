class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :secret, null: false
      t.string :token, nill: false

      t.timestamps
    end
  end
end
