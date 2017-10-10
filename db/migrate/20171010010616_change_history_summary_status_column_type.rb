class ChangeHistorySummaryStatusColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column :histories, :summary_status, :string
  end
end
