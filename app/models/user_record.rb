class UserRecord < ActiveRecord::Base
  include Bifrost::Record
  persists_for User
end
