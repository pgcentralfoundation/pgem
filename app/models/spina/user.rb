module Spina
  class User < ::User

    def self.all
      ::User.where(is_admin: true)
    end

    def admin?
      is_admin?
    end
  end
end