module ApplicationHelper


  def pagination(resource, page, per_page=10)
    pages = (resource.count / per_page.to_f).ceil
    html = '<ul class="pagination">'
    pages.times do |x|
      p = x+1
      html << "<li>"
      if page == p
        html << p.to_s
      else
        html << link_to(p.to_s, polymorphic_path(resource, :page => p))
      end
      html << "</li>"
    end

    html.html_safe
  end

end
