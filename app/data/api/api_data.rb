require_relative '../../../config/environment'
require_relative '../../models/company'
require_relative '../../models/form'
require 'net/http'
require 'json'

module APIData
    def self.get_data
        # get & create Companies
        APIData.get_companies if Company.all.count == 0
        # get & create Forms
        APIData.get_forms if Form.all.empty?
    end

    def self.get_companies
        self::GetCompaniesTableData.all_companies
    end

    def self.get_forms
        Company::MAANG_CIKS.each do |i|
            self::GetFormsTableData.forms_by_cik(i)
        end
    end
end