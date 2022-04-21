class User < ActiveRecord::Base
    has_many :comments
    has_many :forms, through: :comments
    # has_many :comments, through: :forms #omitted for testing
    validates :username, :email, :password, presence: true
    validates :email, uniqueness: true
    has_secure_password
end
