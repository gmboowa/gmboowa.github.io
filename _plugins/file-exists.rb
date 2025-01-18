module Jekyll
  class FileExistsTag < Liquid::Tag
    def initialize(tag_name, file_path, tokens)
      super
      @file_path = file_path.strip
    end

    def render(context)
      # Resolve the full path of the file
      site_source = context.registers[:site].config['source']
      full_path = File.join(site_source, @file_path)

      # Check if the file exists
      File.exist?(full_path).to_s
    rescue StandardError => e
      Jekyll.logger.error "FileExistsTag Error:", e.message
      "false"
    end
  end
end

Liquid::Template.register_tag('file_exists', Jekyll::FileExistsTag)
