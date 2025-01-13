module Jekyll
  module Scholar
    module Utilities
      def scholar_source(source)
        return source if source.start_with?('/') && File.exist?(source)
        File.join(@config['source'], source)
      end
    end
  end
end
