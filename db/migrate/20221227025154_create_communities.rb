class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities do |t|
      t.string :ocid
      t.string :dp_name

      t.timestamps
    end

    create_table :communities_users, id: false do |t|
      t.belongs_to :community
      t.belongs_to :user
    end
  end
end
