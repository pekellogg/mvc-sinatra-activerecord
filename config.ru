require_relative 'config/environment'
require_relative 'app/controllers/application_controller'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
run ApplicationController
use CompaniesController
use FormsController
use UsersController
use CommentsController

def database_exists?
  ActiveRecord::Base.connection
rescue ActiveRecord::NoDatabaseError
  false
else
  true
end

if database_exists? 
  if Company.all.count == 0 && Form.all.count == 0
    APIData.get_data
  end
end
