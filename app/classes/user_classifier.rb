class UserClassifier
    include Singleton

    BLOCKED_COUNTRY_CODES = %w(VN PK BD RU BY DZ VE UA MN)
    def initialize
      @classifier = Marshal.load File.read(Rails.root.join('lib/spamdetection', 'classifier.dat'))
      @rules = [
        { handler: ->(user) { spam_in_bio user }, weight: 0.6, name: 'spam_in_bio' },
        { handler: ->(user) { first_eq_last user }, weight: 0.1, name: 'first_eq_last' },
        { handler: ->(user) { digits_in_name user }, weight: 0.2, name: 'digits_in_name' },
        { handler: ->(user) { from_blocked_country user }, weight: 0.3, name: 'from_blocked_country' },
      ]
    end
    
    def spam_in_bio(user)
      bio = user.biography || ''
      @classifier.classify(bio) == 'Spam'
    end
    
    def first_eq_last(user)
      user.first_name == user.last_name
    end
    
    def digits_in_name(user)
      user.first_name&.scan(/\d/)&.any? || user.last_name&.scan(/\d/)&.any?
    end
    
    def from_blocked_country(user)
      BLOCKED_COUNTRY_CODES.include? user.sign_in_country 
    end
    
    def check(user)
      results = {}
      score = 0
      @rules.each do |rule|
        res = rule[:handler].call(user)
        results[rule[:name]] = res
        score += rule[:weight] if res
      end
      { results: results, score: score }
    end
    
end