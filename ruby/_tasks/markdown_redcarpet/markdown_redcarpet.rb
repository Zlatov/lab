require 'awesome_print'
require 'redcarpet'

doc_markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML.new(with_toc_data: true)
toc_markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML_TOC.new()

markdown_text = File.read('markdown_redcarpet.md')

doc = doc_markdown.render(markdown_text)
toc = toc_markdown.render(markdown_text)

print 'toc: '.red; puts toc
print 'doc: '.red; puts doc
