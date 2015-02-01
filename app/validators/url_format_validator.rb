require 'uri'

class UrlFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    with_protocol = add_protocol(value)
    add_error     = ->() { record.errors[attribute] << (options[:message] || "is not a valid website address.") }
    as_uri        = URI.parse(with_protocol)

    if as_uri.kind_of?(URI::HTTP) and has_tld?(as_uri.host)
      record.send("#{attribute}=", with_protocol)
    else
      add_error.call
    end
  rescue URI::InvalidURIError
    add_error.call
  end


  def add_protocol(address)
    if address =~ /^http:\/\/|^https:\/\//
      address
    else
      "http://#{address}"
    end
  end


  def has_tld?(host)
    host =~ /.+\..+$/
  end

end
