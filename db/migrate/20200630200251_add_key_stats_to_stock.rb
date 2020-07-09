class AddKeyStatsToStock < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :key_stats, :string
  end
end
