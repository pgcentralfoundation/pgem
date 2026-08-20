class AddSendTicketPdfToEmailSettings < ActiveRecord::Migration[4.2]
  def change
    add_column :email_settings, :send_ticket_pdf, :boolean, default: true
  end
end
