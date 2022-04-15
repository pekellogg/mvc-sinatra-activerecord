class User < ActiveRecord::Base
    has_many :comments, through: :forms
    validates :username, :email, :password, presence: true
    validates :email, uniqueness: true
    has_secure_password
end



