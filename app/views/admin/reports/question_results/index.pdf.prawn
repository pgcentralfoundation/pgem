prawn_document(force_download: true, filename: 'question_results.pdf', page_layout: :landscape) do |pdf|
  result_array = []
  header_array = ['Question', 'Type', 'Global', 'Answers']
  result_array << header_array

  # An unbreakable long word (a long answer option, an email address) can make
  # Prawn unable to fit a column at any width, raising Prawn::Errors::CannotFit.
  # Truncate each piece so no single cell can force that.
  cell_max_length = 30

  @questions.each do |question|
    answers = question.qanswers.map { |qa| "#{qa.answer.title.truncate(cell_max_length)}: #{@answer_counts[qa.id] || 0}" }.join(', ')
    row = []
    row << question.title.truncate(cell_max_length)
    row << question.question_type.title
    row << (question.global? ? 'Yes' : 'No')
    row << answers
    result_array << row
  end

  pdf.text "Question Results for #{@conference.short_title}", font_size: 25, align: :center
  pdf.table result_array, header: true, cell_style: { size: 8, border_width: 1 }, position: :center do
    columns(3).align = :right
  end
end
