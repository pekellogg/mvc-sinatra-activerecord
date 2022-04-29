module APIData::GetFormsTableData
    # init CIK
    def self.forms_by_cik(cik)
        @cik = cik
        self.get_forms_by_uri(self.submissions_uri_builder)
        self.new_forms
    end

    # build request URL
    def self.submissions_uri_builder
        uri = 'https://data.sec.gov/submissions/CIK'
        max = 10
        diff = max - @cik.to_s.size
        str = ''
        diff.times do
            str << '0'
        end
        uri + str + @cik.to_s + '.json'
    end

    # ping API for Company dimensions
    def self.get_forms_by_uri(uri)
        response = RestClient.get(uri, headers = {'User-Agent': ENV.fetch("EMAIL")})
        body = JSON.parse(response.body) if response.code == 200
        @accession_nos = body['filings']['recent']['accessionNumber']
        @report_dates = body['filings']['recent']['reportDate']

        self.reformat_report_dates(@report_dates)

        @docs = body['filings']['recent']['primaryDocument']
        @doc_descs = body['filings']['recent']['primaryDocDescription']
    end

    # create collection of objects for ActiveRecord#import => take an array of models
    def self.new_forms
        forms = []
        @accession_nos.each_with_index do |i, index|
            form_uri = self.form_uri_builder(i, index)
            forms << Form.new(cik: @cik, accession_number: i, report_date: @report_dates[index], doc: @docs[index], doc_description: @doc_descs[index], uri: form_uri)
        end
        # import objects collection to db
        Form.ar_import_forms(forms)
        # associate forms to belong_to a company
        self.associate_forms
    end
    
    def self.form_uri_builder(i, index)
        base = "https://www.sec.gov/Archives/edgar/data/#{@cik}/"
        accession_num_no_dashes = i.split("-").join + "/"
        prime_doc = @docs[index]
        uri = base + accession_num_no_dashes + prime_doc
    end

    # associate forms to belong_to a company
    def self.associate_forms
        Company::MAANG_CIKS.each do |cik|
            company = Company.all.find{|c|c.cik == cik}
            form_all = Form.all
            form_all.each do |form|
                if form.cik == company.cik
                    company.forms << form
                end
            end
        end
    end

    private
    # re-format @report_dates to MM/DD/YYYY
    def self.reformat_report_dates(report_dates)
        report_dates.map! do |date| 
            if !date.empty?
                Date.strptime(date.split("-").join, '%Y%m%d').strftime("%m/%d/%Y")
            else
                date
            end
        end
    end
end