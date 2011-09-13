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
end
