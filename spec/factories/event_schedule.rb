# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :event_schedule do
    event
    after(:build) do |event_schedule|
      program = event_schedule.event.program
      unless (venue = program.conference.venue)
        venue = create(:venue, conference: program.conference)
      end
      # Persisting the conference above (if it wasn't already) fires
      # Conference#create_program, whose has_one :program, dependent: :destroy
      # replaces any in-memory program already built for it - destroying this
      # build's `program` as a side effect. Re-fetch the live one when that happens.
      if program.destroyed?
        program = program.conference.reload.program
        event_schedule.event.program = program
      end
      (event_schedule.room = create(:room, venue: venue)) unless event_schedule.room.present?
      (event_schedule.start_time = program.conference.start_date.to_time) unless event_schedule.start_time.present?
      unless event_schedule.schedule.present?
        unless program.selected_schedule.present?
          schedule = create(:schedule, program: program)
          program.schedules << schedule
          program.selected_schedule = schedule
          program.save!
        end
        event_schedule.schedule = program.selected_schedule
      end
    end
  end
end
