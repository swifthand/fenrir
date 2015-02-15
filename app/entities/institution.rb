class Institution
  include Bifrost.entity(finalize: false)

  attribute :name,            String
  attribute :street_address,  String
  attribute :city,            String
  attribute :state,           String
  attribute :postalcode,      String
  attribute :country,         String, default: 'US'
  attribute :leads,           Array['Lead'], default: []

end
