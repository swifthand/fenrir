class MinutesRangeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless MinutesFromMidnight.valid?(value.to_i)
      record.errors[attribute] << (options[:message] || "is not a valid time of day")
    end
  end
end
