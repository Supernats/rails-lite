require 'json'
require 'webrick'

class Session
  def initialize(req)
    @cookie_value = extract_cookie(req) || {}
  end

  def [](key)
    @cookie_value[key]
  end

  def []=(key, val)
    @cookie_value[key] = val
  end

  def extract_cookie(req)
    found_cookie = req.cookies.find do |cookie|
      cookie.name == '_rails_lite_app'
    end
    if found_cookie
      JSON.parse(found_cookie.value)
    else
      nil
    end
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_app',@cookie_value.to_json)
  end
end
