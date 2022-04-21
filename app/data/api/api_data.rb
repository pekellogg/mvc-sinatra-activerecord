require_relative '../../../config/environment'
require_relative '../../models/company'
require_relative '../../models/form'
require 'net/http'
require 'json'

module APIData
    def self.get_companies
        self::GetCompaniesTableData.all_companies
    end

    def self.get_forms
        # Company.connection.select_all("SELECT * FROM companies WHERE cik in '#{Company::CIKS.join(",")}'").to_a
        Company::CIKS.each do |i|
            self::GetFormsTableData.forms_by_cik(i)
        end
    end
end