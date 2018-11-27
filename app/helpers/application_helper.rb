##
# = ApplicationHelper
# Author::    Richard Davis
# Copyright:: Copyright 2018-2019 Mushaka Solutions Inc.
# License::   GNU Public License 3
#
# Collection of helper methods to use across the application.
module ApplicationHelper

  ##
  # Adds method to renderer to scan for code blocks with a specific language,
  # allowing for syntax highlighting.
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language || :text).div
    end
  end

  ##
  # Transforms content provided in markdown syntax into HTML
  def markdown(content)
    coderayified = CodeRayify.new(escape_html: true, hard_wrap: true)
    @markdown ||= Redcarpet::Markdown.new(coderayified, autolink: true,
                                                       space_after_headers: true,
                                                       fenced_code_blocks: true,
                                                       underline: true,
                                                       highlight: true,
                                                       footnotes: true,
                                                       tables: true)
    @markdown.render(content).html_safe
  end
end
