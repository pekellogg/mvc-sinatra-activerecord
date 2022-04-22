require 'activerecord-import'

class Company < ActiveRecord::Base
    self.primary_key = "cik"
    has_many :forms
    #MAANG: meta, amazon, apple, netflix, google
    MAANG_CIKS = [1326801, 1018724, 320193, 1065280, 1652044]

    def self.ar_import_companies(cols, vals)
        self.import cols, vals
    end
end
