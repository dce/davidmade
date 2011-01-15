class Layout < Mustache
  self.template_file = "templates/layout.html.mustache"

  def initialize(title = nil)
    self[:yield] = yield
    self[:title] = title || "Davidmade"
  end
end
