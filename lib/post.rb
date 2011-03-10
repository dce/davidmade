
class Post < Mustache
  include Comparable

  def initialize(file_path)
    @file_path = file_path
    @meta, @body = File.open(@file_path).read.split(/\n\n/, 2)
    @meta = YAML.load(@meta)
    self.template = open("templates/_#{type}.html.mustache").read
  end

  def self.all
    Dir.glob("posts/*").map {|f| new(f) }.sort.reverse
  end

  def self.types
    all.map {|p| p.type }.uniq
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

  def date
    date_time.strftime("%Y-%m-%d")
  end

  def formatted_date
    date_time.strftime("%b %e, %Y")
  end

  def title
    @meta["title"]
  end

  def file
    @meta["file"]
  end

  def body
    RDiscount.new(@body, :smart).to_html if @body
  end

  def type
    @meta["type"] || "text"
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
