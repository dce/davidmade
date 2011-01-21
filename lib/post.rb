
class Post < Mustache
  include Comparable

  def initialize(file_path)
    @file_path = file_path
    @meta, @body = File.open(@file_path).read.split(/\n\n/, 2)
    @meta = YAML.load(@meta)
    self.template = open("templates/_#{type}.html.mustache").read

    open("public/#{url}", "w") do |index|
      layout = Layout.new([title, "DavidMade"].compact * " - ") { render }
      index.write(layout.render)
    end
  end

  def self.all
    Dir.glob("posts/*").map {|f| new(f) }.sort.reverse
  end

  def date_time
    DateTime.parse(@meta["date"].to_s)
  end

  def date
    date_time.strftime("%Y-%m-%d")
  end

  def formatted_date
    date_time.strftime("%b %e, %Y")
  end

  def title
    @meta["title"]
  end

  def title_or_url
    title || url
  end

  def file
    @meta["file"]
  end

  def body
    RDiscount.new(@body, :smart).to_html if @body
  end

  def type
    @meta["type"] || "post"
  end

  def url
    @file_path.gsub(/md$/, "html")
  end

  def timestamp
    date_time.strftime("%Y-%m-%dT%H:%M:%SZ")
  end

  def <=>(other)
    date_time <=> other.date_time
  end
end