class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.string :access_token
      t.string :refresh_token
      t.datetime :access_expired_at
      t.datetime :refresh_expired_at
      t.string :user_agent
      t.references :user, index: true, foreign_key: false

      t.timestamps
    end
  end
end
