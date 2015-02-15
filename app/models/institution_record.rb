class InstitutionRecord < ActiveRecord::Base
  include Bifrost::Record
  persists_for Institution
end
