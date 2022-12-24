class AddIpToToken < ActiveRecord::Migration[7.0]
  def change
    add_column :tokens, :ip, :string
  end
end
