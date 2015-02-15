class PhoneFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank? or value.to_s.gsub(/[\D]/, '').length < 10
      record.errors[attribute] << (options[:message] || "needs to be at least ten digits")
    end
  end
end
