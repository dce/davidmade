require 'nokogiri'

class WidowSmasher
  attr_accessor :content_tags

  def initialize
    self.content_tags = %w(h1 h2 h3 h4 h5 h6 p li blockquote dt dd)
  end

  def smash(html)
    doc = Nokogiri::HTML::DocumentFragment.parse(html, "ASCII")
    parse_nodes(doc.children)
    doc.to_html
  end

  private

  def parse_nodes(nodes)
    nodes.each do |node|
      if content_node?(node)
        remove_widow(node.children)
      else
        parse_nodes(node.children)
      end
    end
  end

  def text_node?(node)
    node.is_a?(Nokogiri::XML::Text) && !node.blank?
  end

  def content_tag?(node)
    content_tags.include?(node.name)
  end

  def content_node?(node)
    content_tag?(node) && !node.children.all? { |child| child.blank? || content_tag?(child) }
  end

  def remove_widow(nodes)
    smash = lambda { |html| html.reverse.sub(" ", "&#160;".reverse).reverse }

    nodes.reverse.each do |node|
      if text_node?(node) && node.to_s.include?(" ")
        node.replace smash[node.to_html]
        return true
      elsif !node.is_a?(Nokogiri::XML::Text)
        return true if remove_widow(node.children)
      end
    end

    false
  end
end
