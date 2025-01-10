prawn_document(force_download: true, filename: "unregistered_speakers.pdf", page_layout: :landscape) do |pdf|
  users_array = []
  header_array = ['Last Name', 'First Name', 'Affiliation', 'Job Title', 'Email',]
  users_array << header_array
  @unregistered_speakers.each do |user|
    row = []
    row << user.last_name
    row << user.first_name
    row << (user.affiliation.present? ? user.affiliation : '')
    row << (user.title.present? ? user.title : '')
    row << user.email
    users_array << row
  end

  pdf.text "Unregistered speakers for #{@conference.short_title}", font_size: 25, align: :center
  pdf.table users_array, header: true, cell_style: {size: 8, border_width: 1}, position: :center
end
