# Adding functionality to Jekyll::Scholar without redefining it
module Jekyll
  module Scholar
    module Utilities
      # Safely add the scholar_source method
      unless method_defined?(:scholar_source)
        def scholar_source(source)
          # Check if the source is an absolute path and exists
          return source if source.start_with?('/') && File.exist?(source)

          # Construct the path relative to the Jekyll source directory
          File.join(@config['source'], source)
        end
      end
    end
  end
end
