# Renders one term group of the repository's CONTEXT.md as a definition list, so
# the site glossary and the domain glossary share a single source of truth.
#
# Usage in a page:  {% context_glossary Factory %}
#
# CONTEXT.md lives at the repository root, outside the Jekyll source, so it is
# read relative to site.source. `jekyll serve` does not watch it: restart the
# server after editing terms.
require "cgi/escape"
require "set"

module ContextGlossary
  CONTEXT_FILE = "../CONTEXT.md"

  Term = Struct.new(:name, :definition, :avoid)

  def self.parse_group(markdown, group)
    lines = markdown.lines.map(&:rstrip)
    start = lines.index { |line| line.strip == "### #{group}" }
    raise ArgumentError, "context_glossary: group '#{group}' not found in CONTEXT.md" unless start

    body = lines[(start + 1)..].take_while { |line| !line.start_with?("## ", "### ") }
    terms = []
    body.each do |line|
      next if line.strip.empty?

      if (match = line.match(/\A\*\*(.+?)\*\*:\s*(.*)\z/))
        terms << Term.new(match[1], +match[2], nil)
        next
      end
      raise ArgumentError, "context_glossary: text before the first term in group '#{group}': #{line}" unless terms.last

      if (match = line.match(/\A_Avoid_:\s*(.+)\z/))
        terms.last.avoid = match[1]
      else
        terms.last.definition << " " unless terms.last.definition.empty?
        terms.last.definition << line.strip
      end
    end
    terms
  end

  def self.slug(name)
    name.downcase.gsub(/[^\p{L}\p{N}]+/, "-").gsub(/\A-|-\z/, "")
  end

  # Renders Markdown with the site's own converter (GFM and the site's kramdown
  # settings) and returns the inner HTML of the single paragraph it produces.
  def self.inline(site, text)
    html = site.find_converter_instance(Jekyll::Converters::Markdown).convert(text).strip
    match = html.match(%r{\A<p>(.*)</p>\z}m)
    raise ArgumentError, "context_glossary: '#{text}' must render as a single paragraph" if match.nil? || match[1].include?("<p>")

    match[1]
  end

  class Tag < Liquid::Tag
    def initialize(tag_name, markup, tokens)
      super
      @group = markup.strip
    end

    def render(context)
      site = context.registers[:site]
      path = File.expand_path(CONTEXT_FILE, site.source)
      terms = ContextGlossary.parse_group(File.read(path), @group)

      # Ids already taken on the page by its Markdown headings.
      page_content = context.registers[:page]&.[]("content").to_s
      used = page_content.lines.filter_map { |line| line[/\A#+\s+(.+)/, 1] }.map { |heading| ContextGlossary.slug(heading) }.to_set

      items = terms.map do |term|
        id = ContextGlossary.slug(term.name)
        raise ArgumentError, "context_glossary: term '#{term.name}' has an empty or duplicate anchor id '#{id}'" if id.empty? || !used.add?(id)

        avoid = term.avoid ? %(\n  <p class="text-grey-dk-000 fs-2">Avoid: #{ContextGlossary.inline(site, term.avoid)}</p>) : ""
        <<~HTML.chomp
          <dt id="#{CGI.escapeHTML(id)}">#{ContextGlossary.inline(site, term.name)}</dt>
          <dd>
            <p>#{ContextGlossary.inline(site, term.definition)}</p>#{avoid}
          </dd>
        HTML
      end
      %(<dl class="glossary">\n#{items.join("\n")}\n</dl>)
    end
  end
end

Liquid::Template.register_tag("context_glossary", ContextGlossary::Tag)
