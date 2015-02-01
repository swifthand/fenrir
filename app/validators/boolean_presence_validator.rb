class BooleanPresenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value == true or value == false
      record.errors[attribute] << (options[:message] || "can't be blank")
    end
  end
end
