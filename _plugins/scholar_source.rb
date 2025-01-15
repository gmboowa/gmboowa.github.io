# Extend Jekyll::Scholar::Utilities safely without redefining the Scholar module
module Jekyll
  module Scholar
    module Utilities
      # Add scholar_source method only if it doesn't already exist
      unless method_defined?(:scholar_source)
        def scholar_source(source)
          # Return source if it is an absolute path and exists
          return source if source.start_with?('/') && File.exist?(source)

          # Construct the path relative to the Jekyll source directory
          File.join(@config['source'], source)
        end
      end
    end
  end
end
