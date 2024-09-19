# frozen_string_literal: true

require "tip_tap"

RSpec.describe TipTap::Nodes::Text do
  describe "to_plain_text" do
    it "returns the text" do
      node = TipTap::Nodes::Text.from_json({text: "Hello World!"})
      text = node.to_plain_text

      expect(text).to eq("Hello World!")
    end
  end

  describe "to_html" do
    context "without marks" do
      it "returns the text" do
        node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: []})
        html = node.to_html

        expect(html).to eq("Hello World!")
      end
    end

    context "with marks" do
      context "bold" do
        it "returns the text wrapped in a strong tag" do
          node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "bold"}]})
          html = node.to_html

          expect(html).to eq("<strong>Hello World!</strong>")
        end
      end

      context "italic" do
        it "returns the text wrapped in a em tag" do
          node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "italic"}]})
          html = node.to_html

          expect(html).to eq("<em>Hello World!</em>")
        end
      end

      context "underline" do
        it "returns the text wrapped in a u tag" do
          node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "underline"}]})
          html = node.to_html

          expect(html).to eq("<u>Hello World!</u>")
        end
      end

      context "strikethrough" do
        it "returns the text wrapped in a s tag" do
          node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "strike"}]})
          html = node.to_html

          expect(html).to eq("<s>Hello World!</s>")
        end
      end

      context "code" do
        it "returns the text wrapped in a code tag" do
          node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "code"}]})
          html = node.to_html

          expect(html).to eq("<code>Hello World!</code>")
        end
      end

      context "bold, italic, and underline" do
        it "returns the text wrapped in a strong, em, and u tags" do
          node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "italic"}, {type: "bold"}, {type: "underline"}]})
          html = node.to_html

          expect(html).to eq("<strong><em><u>Hello World!</u></em></strong>")
        end
      end

      context "link" do
        it "returns the text wrapped in an a tag" do
          node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "link", attrs: {href: "https://example.com", target: "_blank"}}]})
          html = node.to_html

          expect(html).to eq('<a href="https://example.com" target="_blank">Hello World!</a>')
        end
      end

      context "text style" do
        it "returns the text wrapped in a span tag" do
          node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "textStyle", attrs: {color: "#f0f0f0"}}]})
          html = node.to_html

          expect(html).to eq('<span style="color:#f0f0f0;">Hello World!</span>')
        end
      end

      context "superscript" do
        it "returns the text wrapped in a sup tag" do
          node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "superscript"}]})
          html = node.to_html

          expect(html).to eq("<sup>Hello World!</sup>")
        end
      end

      context "subscript" do
        it "returns the text wrapped in a sup tag" do
          node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "subscript"}]})
          html = node.to_html

          expect(html).to eq("<sub>Hello World!</sub>")
        end
      end

      context "highlight" do
        context "without color" do
          it "returns the text wrapped in a mark tag" do
            node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "highlight"}]})
            html = node.to_html

            expect(html).to eq("<mark>Hello World!</mark>")
          end
        end

        context "with color" do
          it "returns the text wrapped in a mark tag with proper attributes" do
            node = TipTap::Nodes::Text.from_json({text: "Hello World!", marks: [{type: "highlight", attrs: {color: "#0f0f0f"}}]})
            html = node.to_html

            expect(html).to eq('<mark data-color="#0f0f0f" style="background-color:#0f0f0f;color:inherit;">Hello World!</mark>')
          end
        end
      end
    end
  end

  describe "to_h" do
    context "with marks" do
      it "returns a JSON object with marks" do
        node = TipTap::Nodes::Text.new("Hello World!", marks: [{type: "bold"}, {type: "italic"}])
        json = node.to_h

        expect(json).to eq({type: "text", text: "Hello World!", marks: [{type: "bold"}, {type: "italic"}]})
      end
    end

    context "whitespace" do
      it "returns a JSON object that preserves whitespace" do
        node = TipTap::Nodes::Text.new(" ")
        json = node.to_h

        expect(json).to eq({type: "text", text: " "})
      end
    end
  end
end
