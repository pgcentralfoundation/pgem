module Admin
  module Reports
    class QuestionResultsController < Admin::BaseController
      load_and_authorize_resource :conference, find_by: :short_title

      def index
        question_ids = (Question.where(global: true).pluck(:id) + @conference.question_ids).uniq
        @questions = Question.where(id: question_ids).includes(:question_type, qanswers: :answer).order(:id)

        @answer_counts = Qanswer.joins(:registrations)
                                 .where(registrations: { conference_id: @conference.id })
                                 .group('qanswers.id')
                                 .count
      end
    end
  end
end
