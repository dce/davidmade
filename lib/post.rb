class Post < Mustache
  include Comparable

  def self.meta(field, opts = {})
    define_method(field) { @meta[field.to_s] || opts[:default] }
  end

  def self.date_format(name, format)
    define_method(name) { date_time.strftime format }
  end

  def self.all
    Dir.glob("posts/*").map {|f| new(f) }.sort.reverse
  end

  def self.types
    all.map(&:type).uniq.sort
  end

  meta :title
  meta :file
  meta :href
  meta :type, :default => "text"

  date_format :date,            "%Y-%m-%d"
  date_format :formatted_date,  "%a, %b %e, %Y"
  date_format :timestamp,       "%Y-%m-%dT%H:%M:%SZ"

  def initialize(file_path)
    @file_path = file_path
    @meta, @body = File.open(@file_path).read.split(/\n\n/, 2)
    @meta = YAML.load(@meta)
    self.template = open("templates/_#{type}.html.mustache").read
  end

  def write
    open("public/#{url}", "w") do |index|
      full_title = [title, "DavidMade"].compact * " - "
      layout = Layout.new(:title => full_title) { render }
      index.write(layout.render)
    end
  end

  def date_time
    DateTime.parse(@meta["date"].to_s)
  end

  def body
    RDiscount.new(@body, :smart).to_html if @body
  end

  def url
    @file_path.gsub /md$/, "html"
  end

  def source_url
    "http://raw.github.com/dce/davidmade/master/#{@file_path}"
  end

  def <=>(other)
    date_time <=> other.date_time
  end

  types.each do |type_name|
    define_method "#{type_name}?" do
      type == type_name
    end
  end
end
