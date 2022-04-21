require 'activerecord-import'

class Company < ActiveRecord::Base
    self.primary_key = "cik"
    has_many :forms
    # AAPL (not in article)
    # Microsoft
    # Amazon
    # Google
    # Infosys
    # Starbucks
    # Deloitte (omitted as not public company)
    # Boeing
    # Accenture
    # Nordstrom
    # Target
    CIKS = [320193]#, 789019, 1018724, 1652044, 1067491, 829224, 12927, 1467373, 72333, 27419]

    def self.ar_import_companies(cols, vals)
        self.import cols, vals
    end
end