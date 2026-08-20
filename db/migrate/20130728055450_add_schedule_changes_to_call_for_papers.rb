class AddScheduleChangesToCallForPapers < ActiveRecord::Migration[4.2]
  def change
    add_column :call_for_papers, :schedule_changes, :boolean, default: false
  end
end
