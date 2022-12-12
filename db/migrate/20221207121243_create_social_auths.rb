class CreateSocialAuths < ActiveRecord::Migration[7.0]
  def change
    create_table :social_auths do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :given_name
      t.string :family_name
      t.string :email
      t.string :photo
      t.references :user, null: false, foreign_key: false

      t.timestamps
    end
  end
end
