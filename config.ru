require_relative 'config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride#(:default)
run ApplicationController
use CompaniesController
use FormsController
use UsersController
use CommentsController

