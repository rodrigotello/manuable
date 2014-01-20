class AddPlanIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :plan_id, :integer
  end
end
