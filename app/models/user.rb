class User < ActiveRecord::Base
    has_many :comments
    validates :username, :email, :password, presence: true
    validates :email, uniqueness: true
    has_secure_password

    def self.valid_username?(str)
        (/^\w*$/.match(str)) ? true : false
    end
end
