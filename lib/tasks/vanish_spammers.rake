namespace :user do
  desc 'Classify and remove spammer users'
  Rails.logger = Logger.new(STDOUT)
  task :vanish_spammers, [:batch_size] => :environment do |t, args|
    args.with_defaults(batch_size: 10000)
    users = User.where(%q{last_sign_in_at - created_at < interval '1 days'}).where({sign_in_count: 1..2}).where('id > ?', 30000).limit(args.batch_size)
    PaperTrail.enabled = false
    SCORE_THRESHOLD = 0.4
    users.each do |user|
      classification = UserClassifier.instance.check user
      if classification[:score] >= SCORE_THRESHOLD
        Rails.logger.info("Permanently deleting spammer account #{user.id}")
        Rails.logger.info("User info: #{user.inspect}")
        Rails.logger.info("Classification result: #{classification}")
        vanish_spammer user
      end
    end
    PaperTrail.enabled = true
  end

  def vanish_spammer(user)
    deleted_versions = PaperTrail::Version.where(whodunnit: user).delete_all
    Rails.logger.info("Deleted papertrail versions created by this account: #{deleted_versions}")
    user.versions.destroy_all
    user.destroy
  end

end
