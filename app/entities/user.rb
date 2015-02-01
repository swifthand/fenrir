class User
  include Bifrost.entity

  attribute :name,    String
  validates :name,    presence: true

  attribute :email,   String
  validates :email,   email_format: true

  attribute :admin,   Boolean, default: false
  validates :admin,   boolean_presence: true

  attribute :active,  Boolean, default: true
  validates :active,  boolean_presence: true

end
