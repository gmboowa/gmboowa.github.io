# Safely extend Jekyll::Scholar::Utilities
module Jekyll
  module Scholar
    module Utilities
      # Add the scholar_source method only if it does not already exist
      unless method_defined?(:scholar_source)
        def scholar_source(source)
          # If source is an absolute path and exists, return it
          return source if source.start_with?('/') && File.exist?(source)

          # Otherwise, construct the path relative to the Jekyll source directory
          File.join(@config['source'], source)
        end
      end
    end
  end
end
