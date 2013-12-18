require 'erb'
require_relative 'params'
require_relative 'session'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params = nil)
    @req = req
    @res = res
    @already_built_response = false
  end

  def session
  end

  def already_rendered?
    @already_built_response
  end

  def redirect_to(url)
    raise "Already built response" if already_rendered?
    # because standards, yo
    @res.set_redirect(WEBrick::HTTPStatus[303], url)
    @already_built_response = true
  end

  def render_content(content, type)
    raise "Already built response" if already_rendered?
    @res.content_type = type
    @res.body = content
    @already_built_response = true
  end

  def render(template_name)
  end

  def invoke_action(name)
  end
end
