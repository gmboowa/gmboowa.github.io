module Jekyll
  class Scholar
    require 'date'

    # Load styles into static memory.
    # They should be thread safe as long as they are
    # treated as being read-only.
    STYLES = {}

    LOCALES = {}

    # Utility methods used by several Scholar plugins. The methods in this
    # module may depend on the presence of #config, #bibtex_files, and
    # #site readers
    module Utilities
      attr_reader :config, :site, :context, :prefix, :text, :offset, :max

      def split_arguments(arguments)
        tokens = arguments.strip.split(/\s+/)
        args = tokens.take_while { |a| !a.start_with?('-') }
        opts = (tokens - args).join(' ')
        [args, opts]
      end

      def optparse(arguments)
        return if arguments.nil? || arguments.empty?

        parser = OptionParser.new do |opts|
          opts.on('-c', '--cited') { @cited = true }
          opts.on('-C', '--cited_in_order') { @cited, @skip_sort = true, true }
          opts.on('--clear') { @clear = true }
          opts.on('-r', '--remove_duplicates [MATCH_FIELDS]') do |match_field|
            @remove_duplicates = true
            @match_fields = match_field.split(/,\s+/) unless match_field.nil?
          end
          opts.on('-A', '--suppress_author') { @suppress_author = true }
          opts.on('-f', '--file FILE') { (@bibtex_files ||= []) << file }
          opts.on('-q', '--query QUERY') { @query = query }
          opts.on('-h', '--bibliography_list_tag TAG') { @bibliography_list_tag = tag }
          opts.on('-p', '--prefix PREFIX') { @prefix = prefix }
          opts.on('-t', '--text TEXT') { @text = text }
          opts.on('-l', '--locator LOCATOR') { locators << locator }
          opts.on('-L', '--label LABEL') { labels << label }
          opts.on('-o', '--offset OFFSET') { @offset = offset.to_i }
          opts.on('-m', '--max MAX') { @max = max.to_i }
          opts.on('-s', '--style STYLE') { @style = style }
          opts.on('-g', '--group_by GROUP') { @group_by = group_by }
          opts.on('-G', '--group_order ORDER') { self.group_order = group_order }
          opts.on('-O', '--type_order ORDER') { @group_by = type_order }
          opts.on('-T', '--template TEMPLATE') { @bibliography_template = template }
        end

        argv = arguments.split(/(\B-[cCfhqptTsgGOlLomAr]|\B--(?:cited(_in_order)?|clear|bibliography_list_tag|file|query|prefix|text|style|group_(?:by|order)|type_order|template|locator|label|offset|max|suppress_author|remove_duplicates))/)

        parser.parse argv.map(&:strip).reject(&:empty?)
      end

      def bibliography_list_tag
        @bibliography_list_tag || config['bibliography_list_tag']
      end

      def allow_locale_overrides?
        !!config['allow_locale_overrides']
      end

      def match_fields
        @match_fields ||= []
      end

      def locators
        @locators ||= []
      end

      def labels
        @labels ||= []
      end

      def bibtex_files
        if config['bibliography'].include?('*')
          @bibtex_files ||= Dir.glob(File.join(config['source'], config['bibliography'])).collect do |f|
            Pathname(f).relative_path_from(Pathname(config['source'])).to_s
          end
        else
          @bibtex_files ||= [config['bibliography']]
        end
      end

      def extend_path(name)
        return name if name.nil? || name.empty?
        return name if name.start_with?('/') && File.exist?(name)

        name = File.join(scholar_source, name)
        name << '.bib' if File.extname(name).empty? && !File.exist?(name)
        name
      end

      def scholar_source
        source = config['source']
        return source if source.start_with?('/') && File.exist?(source)

        File.join(site.source, source)
      end

      def relative
        config['relative']
      end

      def bibliography
        paths = bibtex_files.map { |file| extend_path(file) }
        @bibliography ||= BibTeX::Bibliography.parse(
          paths.reduce('') { |s, p| s << IO.read(p) },
          bibtex_options
        )
      end

      def bibtex_options
        @bibtex_options ||= (config['bibtex_options'] || {}).symbolize_keys
      end

      def bibtex_filters
        config['bibtex_filters'] ||= []
      end

      def raw_bibtex_filters
        config['raw_bibtex_filters'] ||= []
      end

      def generate_details_link?
        !!config['details_link']
      end

      def replace_strings?
        config['replace_strings']
      end

      def join_strings?
        config['join_strings']
      end

      def cited_only?
        !!@cited
      end

      def clear?
        !!@clear
      end

      def skip_sort?
        @skip_sort || config['sort_by'] == 'none'
      end
    end
  end
end

