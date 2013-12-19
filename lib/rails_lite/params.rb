require 'uri'

class Params
  def initialize(req, route_params = nil)
    @params = parse_request(req)
  end

  def [](key)
    @params[key]
  end

  def to_s
    @params.to_json
  end

  private
  def parse_www_encoded_form(www_encoded_form)
    parsed_hash = {}
    parsed_array = URI.decode_www_form(www_encoded_form)
    unless parsed_array.empty?
      parsed_array.each do |component|
        parsed_hash[component[0]] = component[1]
      end
    end
    parsed_hash
  end

  def parse_request(req)
    body_hash  = parse_www_encoded_form(req.body.to_s)
    query_hash = parse_www_encoded_form(req.query_string.to_s)
    body_hash.merge(query_hash)
  end

  def parse_key(key)

  end
end
