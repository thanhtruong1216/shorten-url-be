class AddClicksCountToLinks < ActiveRecord::Migration[6.1]
  def change
    add_column :links, :clicks_count, :integer
  end
end
