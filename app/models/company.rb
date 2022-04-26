require 'activerecord-import'

class Company < ActiveRecord::Base
    self.primary_key = "cik"
    has_many :forms
    #MAANG: meta, amazon, apple, netflix, google
    MAANG_CIKS = [1326801, 1018724, 320193, 1065280, 1652044]

    def self.ar_import_companies(cols, vals)
        self.import cols, vals
    end

    def self.sorted_companies
        self.all.sort
    end

    def self.all_forms_msgs(companies)
        container = {}
        companies.each do |c|
            container[c.cik] = c.company_forms_msgs
        end
        container
    end

    def company_forms_msgs
        msgs = []
        self.forms_report_date_desc.each do |f|
            form_msg = []
            if !f.doc_description.empty? && !f.report_date.empty?
                form_msg << "#{f.doc_description} filed on: #{f.report_date}"
            end
            form_msg << "See full details: #{f.uri}" if f.uri
            msgs << form_msg
        end
        msgs
    end

    def forms_report_date_desc
        self.forms.order('report_date DESC')
    end
end
