class AddInfoForAcceptedUsersToEvents < ActiveRecord::Migration
  def change
    add_column :events, :info_for_accepted_users, :text
  end
end
