require_relative './config/environment'
require 'net/http'
require 'json'

class APIData

    module GetCompaniesTableData
        # ping API for entire file contents
        uri = 'https://www.sec.gov/files/company_tickers.json'
        response = RestClient.get(uri)
        body = JSON.parse(response.body) if response.code == 200

        # grab each property's value such that values = [[320193, "AAPL", "Apple Inc."], [789019, "MSFT", "MICROSOFT CORP"]]
        values = []
        body.each do |i, company|
            container = []
            container << company['cik_str']
            container << company['ticker']
            container << company['title']
            values << container
        end

        # pass columns and values to ActiveRecord #import to create ciks table
        columns = ['cik_str'.to_sym, 'ticker'.to_sym, 'title'.to_sym]
        Company.import columns, values
    end

    module GetFormsTableData
        def get_submissions(uri)
            response = RestClient.get(uri, headers = {'User-Agent': 'peytonkellogg@gmail.com'})
            body = JSON.parse(response.body) if response.code == 200
            @accession_nos = body['filings']['recent']['accessionNumber']
            @report_dates = body['filings']['recent']['reportDate']
            @docs = body['filings']['recent']['primaryDocument']
            @doc_descs = body['filings']['recent']['primaryDocDescription']
        end

        def submissions_uri_builder(cik)
            uri = 'https://data.sec.gov/submissions/CIK'
            max = 10
            diff = max - cik.to_s.size
            str = ''
            diff.times do
                str << '0'
            end
            uri + str + cik.to_s + '.json'
        end

        # def forms_builder(cik)
        #     uri = 'https://www.sec.gov/Archives/edgar/data/<CIK>/<"accessionNumber" minus dashes>/<"primaryDocument">'
        # end

        # confirm import of 1 column at a time per ActiveRecord & import gem
        columns = ['accessionNumber'.to_sym]
        values = @accession_nos
        # columns = ['accessionNumber'.to_sym, 'reportDate'.to_sym, 'primaryDocument'.to_sym, 'primaryDocDescription'.to_sym]
        Form.import columns, values, validate: false
    end

end