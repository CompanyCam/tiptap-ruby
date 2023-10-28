# frozen_string_literal: true

require "tip_tap"
require "json"

RSpec.describe TipTap do
  it "has a version number" do
    expect(TipTap::VERSION).not_to be nil
  end

  describe "full integration test" do
    let(:json) { JSON.parse(File.read("spec/support/files/tiptap-state.json")) }
    let(:document) { TipTap::Document.from_json(json) }

    it "parses the json and returns the html" do
      expect(document.to_html).to eq(
        '<div class="tiptap-document"><h1>Site Summary Overview - <em>May 2nd 2023</em></h1><img src="https://img.companycam.com/5zVdNKWQ1hqPOD-IspzX3kMsodTPlv6n39kgerOGjc4/rs:fit:4032:4032/q:100/aHR0cHM6Ly9jb21w/YW55Y2FtLXBlbmRp/bmcuczMuYW1hem9u/YXdzLmNvbS82OTc5/YmFlZS03MzU5LTQy/OWYtYmFhYS0yMmVl/NDY1NWZhODUuanBn.jpg" /><p>This is a site visit summary that is being <strong>synthesized</strong> by <strong><em>Chad Wilken.</em></strong></p><p></p><ul class="task-list"><li class="task-item checked"><p>Todo 1</p></li><li class="task-item"><p><strong>Todo 2</strong></p></li><li class="task-item"><p><strong><em>Todo 3</em></strong></p></li></ul><p></p><h2>This is a heading 2</h2><h3>This is a heading 3</h3><p></p><ul class="bullet-list"><li class="list-item"><p>This is a bullet item</p></li><li class="list-item"><p><strong>This is </strong><em>another item</em></p></li></ul><p>Final paragraph.</p></div>'
      )
    end

    it "parses the json and returns the plain text" do
      expect(document.to_plain_text).to eq(
        "Site Summary Overview -  May 2nd 2023  This is a site visit summary that is being  synthesized  by  Chad Wilken.  Todo 1 Todo 2 Todo 3  This is a heading 2 This is a heading 3  This is a bullet item This is  another item Final paragraph."
      )
    end

    it "parses the json and serializes it back to json" do
      document_2 = TipTap::Document.from_json(document.to_json)
      expect(document.to_json).to eq(document_2.to_json)
    end
  end
end
