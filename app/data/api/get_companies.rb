module APIData::GetCompaniesTableData
    def self.all_companies
        # ping API for entire file contents
        uri = 'https://www.sec.gov/files/company_tickers.json'
        response = RestClient.get(uri)
        body = JSON.parse(response.body) if response.code == 200
        # grab each property's value such that values = [[320193, "AAPL", "Apple Inc."], [789019, "MSFT", "MICROSOFT CORP"]]
        companies = []
        body.each do |i, company|
            container = []
            container << company['cik_str']
            container << company['ticker']
            container << company['title']
            companies << container
        end

        # pass columns and values to ActiveRecord #import to create ciks table
        columns = ['cik'.to_sym, 'ticker'.to_sym, 'title'.to_sym]
        Company.ar_import_companies(columns, companies)
    end
end