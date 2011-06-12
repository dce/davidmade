class Layout < Mustache
  self.template_file = "templates/layout.html.mustache"

  def initialize(opts = {})
    self[:yield] = yield

    if opts[:post_type]
      self[:post_type] = opts[:post_type]
      self[:title] = "#{self[:post_type].capitalize} - Davidmade"
    end

    self[:title] ||= opts[:title] || "Davidmade"
  end

  def post_types
    Post.types.map do |type|
      { :label => type.capitalize,
        :url => "/#{type}/",
        :active => (type == self[:post_type]) }
    end
  end
end
