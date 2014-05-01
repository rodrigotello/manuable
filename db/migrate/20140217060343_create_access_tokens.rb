class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.string :token
      t.integer :user_id
      t.datetime :expires_at

      t.timestamps
    end
  end
end
