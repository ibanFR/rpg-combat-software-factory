# Renders one term group of the repository's CONTEXT.md as a definition list, so
# the site glossary and the domain glossary share a single source of truth.
#
# Usage in a page:  {% context_glossary Factory %}
#
# CONTEXT.md lives at the repository root, outside the Jekyll source, so it is
# read relative to site.source. `jekyll serve` does not watch it: restart the
# server after editing terms.
require "cgi"

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
      if (match = line.match(/\A\*\*(.+)\*\*:\s*\z/))
        terms << Term.new(match[1], +"", nil)
      elsif (match = line.match(/\A_Avoid_:\s*(.+)\z/))
        terms.last.avoid = match[1] if terms.last
      elsif !line.strip.empty? && terms.last
        terms.last.definition << " " unless terms.last.definition.empty?
        terms.last.definition << line.strip
      end
    end
    terms
  end

  def self.slug(name)
    name.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-\z/, "")
  end

  def self.inline(text)
    Kramdown::Document.new(text).to_html.strip.sub(/\A<p>/, "").sub(%r{</p>\z}, "")
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

      items = terms.map do |term|
        avoid = term.avoid ? %(\n  <p class="text-grey-dk-000 fs-2">Avoid: #{CGI.escapeHTML(term.avoid)}</p>) : ""
        <<~HTML.chomp
          <dt id="#{ContextGlossary.slug(term.name)}">#{CGI.escapeHTML(term.name)}</dt>
          <dd>
            <p>#{ContextGlossary.inline(term.definition)}</p>#{avoid}
          </dd>
        HTML
      end
      %(<dl class="glossary">\n#{items.join("\n")}\n</dl>)
    end
  end
end

Liquid::Template.register_tag("context_glossary", ContextGlossary::Tag)
