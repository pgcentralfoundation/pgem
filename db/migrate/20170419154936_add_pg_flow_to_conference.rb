class AddPgFlowToConference < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :use_pg_flow, :boolean, default: true
  end
end
