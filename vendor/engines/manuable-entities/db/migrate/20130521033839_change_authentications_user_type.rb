class ChangeAuthenticationsUserType < ActiveRecord::Migration
  def up
    connection.execute(%q{
      alter table authentications
      alter column user_id
      type integer using cast(user_id as integer)
    })
  end

  def down
    # change_column :authentications, :user_id, :string
  end
end
