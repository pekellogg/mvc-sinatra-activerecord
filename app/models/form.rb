require 'activerecord-import'

class Form < ActiveRecord::Base
    has_many :comments

    def self.ar_import_forms(collection)
        self.import collection
    end
end