class AddRequireRegistrationToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :require_registration, :boolean
  end
end
