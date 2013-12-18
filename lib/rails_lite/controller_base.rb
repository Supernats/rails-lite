require 'erb'
require_relative 'params'
require_relative 'session'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params = nil)
    @req = req
    @res = res
  end

  def session
  end

  def already_rendered?
  end

  def redirect_to(url)
  end

  def render_content(content, type)
    @res.content_type = type
    @res.body = content
  end

  def render(template_name)
  end

  def invoke_action(name)
  end
end
