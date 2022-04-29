class Comment < ActiveRecord::Base
    validates :text, presence: true
    belongs_to :form
    belongs_to :user
end