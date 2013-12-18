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
    # Keeping with Ned's "lazy" protocol, leaving "_controller" on.
    # For reference, name.underscore.slice(0..-12) would've done what we want.
    controller_name = self.class.name.underscore
    template = File.read("views/#{controller_name}/#{template_name}.html.erb")
    content = ERB.new(template).result(binding)
    render_content(content,"text/html")
  end

  def invoke_action(name)
  end
end
