require 'activerecord-import'

class Form < ActiveRecord::Base
    has_many :comments
    has_many :users, through: :comments #(maybe?)
    # belongs_to :company

    def self.ar_import_forms(collection)
        self.import collection
    end
end