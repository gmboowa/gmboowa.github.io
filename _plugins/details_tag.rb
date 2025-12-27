module Jekyll
  class DetailsTag < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
      @summary = markup.strip
    end

    def render(context)
      content = super
      <<~HTML
        <details>
          <summary>#{@summary}</summary>
          #{content}
        </details>
      HTML
    end
  end
end

Liquid::Template.register_tag('details', Jekyll::DetailsTag)
