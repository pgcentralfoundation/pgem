class AddExtraInformationToTicket < ActiveRecord::Migration[4.2]
  def change
    add_column :tickets, :extra_info, :text
  end
end
