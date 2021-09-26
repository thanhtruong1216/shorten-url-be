class CreateApiKeys < ActiveRecord::Migration[6.1]
  def change
    create_table :api_keys do |t|
      t.string :token, null: false
      t.references :user
      t.timestamps
    end

    add_index :api_keys, :token, unique: true
  end
end
