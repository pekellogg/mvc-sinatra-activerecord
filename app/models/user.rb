class User < ActiveRecord::Base
    has_many :comments
    validates :username, :email, :password, presence: true
    validates_uniqueness_of :username
    validates_uniqueness_of :email
    VALID_EMAIL = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/i
    validates :email, format: VALID_EMAIL
    has_secure_password
end
