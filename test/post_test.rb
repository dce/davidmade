require 'test/test_helper'

context "A post" do
  context "with no specified type" do
    setup { Post.new('test/sample_data/text.md') }

    asserts("type") { topic.type }.equals("text")
    asserts("title") { topic.title }.equals("DOIT")
    asserts("file") { topic.file }.nil
    asserts("href") { topic.href }.nil

    context "formatting date" do
      asserts("date") { topic.date }.equals("2011-03-31")
      asserts("formatted date") { topic.formatted_date }.equals("Thu, Mar 31, 2011")
      asserts("timestamp") { topic.timestamp }.equals("2011-03-31T00:00:00Z")
    end
  end

  context "with an audio clip" do
    setup { Post.new('test/sample_data/audio.md') }
    asserts("type") { topic.type }.equals("audio")
    asserts("file") { topic.file }.equals("solo-piano-1.mp3")
  end

  context "with a link" do
    setup { Post.new('test/sample_data/link.md') }
    asserts("type") { topic.type }.equals("link")
    asserts("href") { topic.href }.equals("http://www.url.com")
  end
end
