# Plugin to add support for {% details %} tags in Jekyll
# This plugin enables collapsible <details> HTML elements in Jekyll using Liquid tags.
# Inspired by: http://movb.de/jekyll-details-support.html

module Jekyll
  class DetailsTag < Liquid::Block
    def initialize(tag_name, markup, tokens)
      super
      @summary = markup.strip
    end

    def render(context)
      # Get the site's Markdown converter
      site = context.registers[:site]
      converter = site.find_converter_instance(::Jekyll::Converters::Markdown)

      # Convert the summary and block content to HTML
      summary_html = @summary
      content_html = converter.convert(super(context)).strip

      # Return the rendered HTML for the <details> element
      <<~HTML
        <details>
          <summary>#{summary_html}</summary>
          #{content_html}
        </details>
      HTML
    end
  end
end

# Register the custom Liquid tag
Liquid::Template.register_tag('details', Jekyll::DetailsTag)

