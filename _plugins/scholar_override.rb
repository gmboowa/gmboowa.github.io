module Jekyll
  module Scholar
    module Utilities
      def scholar_source(source)
        # Use `File.exist?` instead of the deprecated `File.exists?`
        return source if source.start_with?('/') && File.exist?(source)

        # Construct the path relative to the Jekyll source directory
        File.join(@config['source'], source)
      end
    end
  end
end
