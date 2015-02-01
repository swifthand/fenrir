class Lead
  include Bifrost.entity

  attribute :description, String
  attribute :status,      String
  # attribute :user,        'User'
  # attribute :lead,        'Lead'

  shared_behavior do
    validate :description,  presence: true
    validate :status,       inclusion: { in: Lead.statuses }
  end

  def self.statuses
    [ 'new',
      'waiting_on_user',
      'awaiting_response',
      'closed_failure',
      'closed_success',
    ]
  end

end
