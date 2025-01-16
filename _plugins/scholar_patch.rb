module Jekyll
  module Scholar
    module Utilities
      def scholar_source(source)
        # Ensure source is an absolute path and exists
        if source.start_with?('/') && File.exist?(source)
          return source
        end

        # Otherwise, resolve relative to the configured source directory
        File.join(@config['source'], source)
      end
    end
  end
end
