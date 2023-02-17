class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :location
      t.boolean :allday
      t.datetime :start
      t.datetime :end
      t.belongs_to :community

      t.timestamps
    end

    create_table :events_users , id: false do |t|
      t.belongs_to :event
      t.belongs_to :user
    end
  end
end
