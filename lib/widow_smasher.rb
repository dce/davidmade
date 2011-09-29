require 'nokogiri'

class WidowSmasher
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

  def content_node?(node)
    node.children.any? { |child| text_node?(child) }
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
