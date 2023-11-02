# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::TaskList do
  describe "to_html" do
    it "returns a ul tag" do
      node = TipTap::Nodes::TaskList.from_json({content: []})
      html = node.to_html

      expect(html).to be_a(String)
      expect(html).to eq('<ul class="task-list"></ul>')
    end
  end

  describe "to_h" do
    it "returns a JSON object" do
      node = TipTap::Nodes::TaskList.new
      json = node.to_h

      expect(json).to eq({type: "taskList", content: []})
    end
  end

  describe "task_item" do
    it "adds a task to the list" do
      node = TipTap::Nodes::TaskList.new
      node.task_item do |ti|
        ti.paragraph do |para|
          para.text("Hello World!")
        end
      end

      expect(node.content.first).to be_a(TipTap::Nodes::TaskItem)
    end
  end
end
