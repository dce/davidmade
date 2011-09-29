require 'test/test_helper'

context "The WidowSmasher" do
  setup { WidowSmasher.new }

  context "with a single HTML tag" do
    setup { topic.smash("<p>these are words</p>") }
    asserts("removes widow") { topic }.equals("<p>these are&#160;words</p>")
  end

  context "with multiple HTML tags" do
    setup { topic.smash("<p>one word</p><p>two words</p>") }
    asserts("removes widows") { topic }.equals("<p>one&#160;word</p><p>two&#160;words</p>")
  end

  context "with a non-block-level nested tag" do
    setup { topic.smash "<p>This is <strong>important</strong>.</p>" }
    asserts("removes widow") { topic }.equals("<p>This is&#160;<strong>important</strong>.</p>")
  end

  context "with nested HTML tags" do
    setup { topic.smash("<ul><li>one word</li><li>two words</li></ul>").gsub(/\n/, '') }
    asserts("removes widows") { topic }.equals("<ul><li>one&#160;word</li><li>two&#160;words</li></ul>")
  end

  context "with a space inside an HTML tag" do
    setup { topic.smash('<p><a href="http://google.com/">Google</a></p>') }
    asserts("does nothing") { topic }.equals('<p><a href="http://google.com/">Google</a></p>')
  end

  context "with text and a short link" do
    setup { topic.smash('<p>This is a <a href="#">link</a></p>') }
    asserts("removes widow before link") { topic }.equals('<p>This is a&#160;<a href="#">link</a></p>')
  end

  context "with text, a long link, and ending text" do
    setup { topic.smash('<p>This is a <a href="#">long link</a>.</p>') }
    asserts("puts nbsp inside link") { topic }.equals('<p>This is a <a href="#">long&#160;link</a>.</p>')
  end

  context "with paragraph consisting of two links" do
    setup { topic.smash('<p><a href="#">link one</a><a href="#">link two</a></p>') }
    asserts("only escapes second link") { topic }.equals('<p><a href="#">link one</a><a href="#">link&#160;two</a></p>')
  end

  context "with a div with two paragraphs and free text" do
    setup do
      html = '<div>some text<p>paragraph 1</p><p>paragraph 2</p></div>'
      topic.smash(html).gsub(/(  |\n)/, "")
    end

    asserts("escapes both paragraphs") { topic }.equals('<div>some text<p>paragraph&#160;1</p><p>paragraph&#160;2</p></div>')
  end

  context "with a UL containing paragraphs" do
    setup do
      html = <<-HTML
        <div>
          <ul>
            <li>some text</li>
            <li>
              <p>par. 1</p>
              <p>par. 2</p>
            </li>
          </ul>
        </div>
      HTML

      topic.smash(html).gsub(/(  |\n)/, "")
    end

    asserts("escapes all LIs and Ps") { topic }.equals("<div><ul><li>some&#160;text</li><li><p>par.&#160;1</p><p>par.&#160;2</p></li></ul></div>")
  end

  context "with span as a content container" do
    setup do
      topic.content_tags << "span"
      topic.smash("<p><span>span 1</span><span>span 2</span></p>")
    end

    asserts("escapes all spans") { topic }.equals("<p><span>span&#160;1</span><span>span&#160;2</span></p>")
  end
end
