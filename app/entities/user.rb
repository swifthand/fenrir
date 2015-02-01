class User
  include Bifrost.entity

  attribute :first_name,  String
  attribute :last_name,   String
  attribute :email,       String
  attribute :admin,       Boolean, default: false
  attribute :active,      Boolean, default: true

  share_behavior do
    validates :first_name,    presence: true
    validates :last_name,     presence: true
    validates :email,         email_format: true
    validates :active,        boolean_presence: true
    validates :admin,         boolean_presence: true
  end

end
