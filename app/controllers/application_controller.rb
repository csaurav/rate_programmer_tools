class ApplicationController < ActionController::Base
  protect_from_forgery
  Roles = {member: 'MEMBER', admin: 'ADMIN' }
end
