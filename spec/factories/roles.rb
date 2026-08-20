FactoryBot.define do
  factory :role do
    association :resource, factory: :conference
    name { 'my role' }

    # Conference#create_roles already auto-creates these 4 named roles for any
    # conference it builds, so reuse that role instead of creating a duplicate
    # (which would collide on the name+resource uniqueness validation).
    factory :organizer_role do
      name { 'organizer' }
      initialize_with { resource.roles.find_by(name: name) || new }
    end

    factory :cfp_role do
      name { 'cfp' }
      initialize_with { resource.roles.find_by(name: name) || new }
    end

    factory :info_desk_role do
      name { 'info_desk' }
      initialize_with { resource.roles.find_by(name: name) || new }
    end

    factory :volunteers_coordinator_role do
      name { 'volunteers_coordinator' }
      initialize_with { resource.roles.find_by(name: name) || new }
    end
  end
end
