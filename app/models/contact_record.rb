class ContactRecord < ActiveRecord::Base
  include Bifrost::Record
  persists_for Contact
end
