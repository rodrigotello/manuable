class AddNotesAndBenefitsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :notes, :text
    add_column :events, :benefits, :text
  end
end
