class AddInternalEventToEventType < ActiveRecord::Migration[4.2]
  def change
    add_column :event_types, :internal_event, :boolean, default: false
  end
end
