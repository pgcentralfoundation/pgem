class AddProspectusToSponsorshipInfo < ActiveRecord::Migration[4.2]
  def change
    add_column :sponsorship_infos, :prospectus, :string
  end
end
