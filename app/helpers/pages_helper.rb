module PagesHelper
  def show_tree(page)
    tree = "<li>#{link_to page.name, subpage_path(page)}</li>"
    if page.has_children?
      tree += "<ul>"
      page.children.each do |page|
        tree += "#{show_tree(page)}"
      end
      tree += "</ul>"
    end
    tree.html_safe
  end
  
  # https://apidock.com/ruby/String/gsub

  def markdown(page)
    text_content = page.content
    text_content.gsub!(/\*\*(?<bold>.*)\*\*/, '<b>\k<bold></b>')
    text_content.gsub!(/\\\\(?<ital>.*)\\\\/, '<i>\k<ital></i>')
    text_content.gsub!(/\(\((?<link>.*) (?<name>.*)\)\)/, '<a href="/\k<link>">\k<name></a>') 
  
    text_content.html_safe
  end 

end
