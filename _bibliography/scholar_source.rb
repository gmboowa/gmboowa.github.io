module Jekyll
  module Scholar
    module Utilities
      # Ensure this method is appended or added to the existing Utilities module
      def scholar_source(source)
        # Check if the source is an absolute path and exists
        return source if source.start_with?('/') && File.exist?(source)

        # Otherwise, construct the path relative to the Jekyll source directory
        File.join(@config['source'], source)
      end
    end
  end
end