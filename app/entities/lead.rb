class Lead
  include Bifrost.entity

  attribute :first_name,  String
  attribute :last_name,   String
  attribute :phone,       String
  attribute :email,       String
  attribute :position,    String
  attribute :properties,  Hash,   default: {}
  # attribute :assigned_to, 'User'
  # attribute :contacts,    Array['Contact'], default: []

  share_behavior do
    validate :first_name, presence: true
    validate :last_name,  presence: true
    validate :phone,      phone_format: true
    validate :email,      email_format: true
    validate :position,   presence: true
  end

end
