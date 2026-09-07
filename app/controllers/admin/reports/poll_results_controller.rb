module Admin
  module Reports
    class PollResultsController < Admin::BaseController
      load_and_authorize_resource :conference, find_by: :short_title
      load_and_authorize_resource :poll, through: :conference, singleton: true

      def index
        @poll_results = []
        @poll_results = PollResult.joins(:survey_question)
                                   .where(survey_questions: { survey_id: @poll.survey_id }) if @poll
      end
    end
  end
end
