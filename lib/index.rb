class Index < Mustache
  def initialize(posts, opts = {})
    self[:posts] = posts
    self[:updated_at] = posts.first.timestamp

    template_file = "templates/index.#{ opts[:format] || "html" }.mustache"
    self.template = open(template_file).read
  end
end
