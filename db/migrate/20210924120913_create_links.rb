class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string     :url, null: false
      t.string     :slug

      t.timestamps
    end
  end
end
