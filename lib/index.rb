class Index < Mustache
  self.template_file = "templates/index.html.mustache"

  def initialize(posts)
    self[:posts] = posts
  end
end
