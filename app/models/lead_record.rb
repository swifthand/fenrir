class LeadRecord < ActiveRecord::Base
  include Bifrost::Record
  persists_for Lead
end
