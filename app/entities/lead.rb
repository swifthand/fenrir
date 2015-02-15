class Lead
  include Bifrost.entity(finalize: false)

  attribute :first_name,  String
  attribute :last_name,   String
  attribute :phone,       String
  attribute :email,       String
  attribute :position,    String
  attribute :properties,  Hash,   default: {}
  attribute :assigned_to, 'User'
  attribute :contacts,    Array['Contact'], default: []

  share_behavior do
    validates :first_name, presence: true
    validates :last_name,  presence: true
    validates :phone,      phone_format: true
    validates :email,      email_format: true
    validates :position,   presence: true
  end

end
