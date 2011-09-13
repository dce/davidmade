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
      if node_is_text?(node)
        node.replace(remove_widow(node.to_html))
      else
        parse_nodes(node.children)
      end
    end
  end

  def node_is_text?(node)
    node.children.any? { |child| child.is_a?(Nokogiri::XML::Text) && !child.blank? }
  end

  def remove_widow(html)
    html.reverse.sub(" ", "&#160;".reverse).reverse
  end
end
