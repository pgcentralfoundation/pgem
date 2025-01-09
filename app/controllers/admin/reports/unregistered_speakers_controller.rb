module Admin
  module Reports
    class UnregisteredSpeakersController < Admin::BaseController
      load_and_authorize_resource :conference, find_by: :short_title

      def index
        registered_user_ids = @conference.registrations.pluck(:user_id)
        unregistered_speaker_ids = EventUser.where(event: @conference.program.events.where(state: 'confirmed'), event_role: 'speaker').where.not(user_id: registered_user_ids).pluck(:user_id)
        @unregistered_speakers = User.where(id: unregistered_speaker_ids)
      end
    end
  end
end
