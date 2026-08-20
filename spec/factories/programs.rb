# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :program do
    schedule_public { false }
    schedule_fluid { false }
    conference

    # Program#selected_schedule and Schedule#program are both required, so
    # neither can be created first through normal validated saves. Persist
    # the program without validation, then build its schedule for real.
    to_create do |instance|
      instance.save(validate: false)
      schedule = FactoryBot.create(:schedule, program: instance)
      instance.update_column(:selected_schedule_id, schedule.id)
      instance.reload
    end
  end
end
