module Jekyll
  class FileExistsTag < Liquid::Tag

    # Initialize the tag with the given path parameter
    def initialize(tag_name, path, tokens)
      super
      @path = path.strip # Strip whitespace from the path
    end

    def render(context)
      # Render the path using Liquid to allow for dynamic values
      rendered_path = Liquid::Template.parse(@path).render(context)

      # Resolve the full file path by appending the site source directory
      site_source = context.registers[:site].config['source']
      file_path = File.join(site_source, rendered_path.strip)

      # Return true if the file exists, false otherwise
      File.exist?(file_path).to_s
    rescue StandardError => e
      # Log an error message and return false if any exception occurs
      Jekyll.logger.error "FileExistsTag Error:", e.message
      "false"
    end
  end
end

# Register the custom Liquid tag
Liquid::Template.register_tag('file_exists', Jekyll::FileExistsTag)
