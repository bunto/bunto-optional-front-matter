module BuntoOptionalFrontMatter
  class Generator < Bunto::Generator
    attr_accessor :site

    safe true
    priority :normal

    def initialize(site)
      @site = site
    end

    def generate(site)
      @site = site
      return if site.config["require_front_matter"]
      site.pages.concat(pages_to_add)
    end

    private

    # An array of Bunto::Pages to add, *excluding* blacklisted files
    def pages_to_add
      pages.reject { |page| blacklisted?(page) }
    end

    # An array of potential Bunto::Pages to add, *including* blacklisted files
    def pages
      markdown_files.map { |static_file| page_from_static_file(static_file) }
    end

    # An array of Bunto::StaticFile's with a site-defined markdown extension
    def markdown_files
      site.static_files.select { |file| markdown_converter.matches(file.extname) }
    end

    # Given a Bunto::StaticFile, returns the file as a Bunto::Page
    def page_from_static_file(static_file)
      base = static_file.instance_variable_get("@base")
      dir  = static_file.instance_variable_get("@dir")
      name = static_file.instance_variable_get("@name")
      Bunto::Page.new(site, base, dir, name)
    end

    # Does the given Bunto::Page match our filename blacklist?
    def blacklisted?(page)
      return false if whitelisted?(page)
      FILENAME_BLACKLIST.include?(page.basename.upcase)
    end

    def whitelisted?(page)
      return false unless site.config["include"].is_a? Array
      entry_filter.included?(page.path)
    end

    def markdown_converter
      @markdown_converter ||= site.find_converter_instance(Bunto::Converters::Markdown)
    end

    def entry_filter
      @entry_filter ||= Bunto::EntryFilter.new(site)
    end
  end
end
