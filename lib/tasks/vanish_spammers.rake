namespace :user do
  desc 'Classify and remove spammer users'
  Rails.logger = Logger.new(STDOUT)
  task :vanish_spammers, [:batch_size] => :environment do |t, args|
    args.with_defaults(batch_size: 10000)
    users = User.where(%q{last_sign_in_at - created_at < interval '2 days'}).where({sign_in_count: 1..2}).where('id > ?', 30000).limit(args.batch_size)
    PaperTrail.enabled = false
    SCORE_THRESHOLD = 0.4
    spammer_ids = []
    users.each do |user|
      
      classification = UserClassifier.instance.check user
      if classification[:score] >= SCORE_THRESHOLD
        Rails.logger.info("Permanently deleting spammer account #{user.id}")
        Rails.logger.info("User info: #{user.inspect}")
        Rails.logger.info("Classification result: #{classification}")
        # vanish_spammer user
        spammer_ids << user.id unless user.registrations.any?
      end
    end
    User.where(id: spammer_ids).destroy_all
    PaperTrail::Version.where(whodunnit: spammer_ids).delete_all

    PaperTrail.enabled = true
  end
end
