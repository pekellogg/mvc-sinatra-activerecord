class Form < ActiveRecord::Base
    has_many :comments
    belongs_to :company
end