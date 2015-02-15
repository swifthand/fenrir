class Contact
  include Bifrost.entity(finalize: false)

  attribute :description, String
  attribute :status,      String
  attribute :user,        'User'
  attribute :lead,        'Lead'

  def self.statuses
    [ 'new',
      'waiting_on_user',
      'awaiting_response',
      'closed_failure',
      'closed_success',
    ]
  end

  share_behavior do
    validate :description,  presence: true
    validate :status,       inclusion: { in: Contact.statuses }
  end

end
