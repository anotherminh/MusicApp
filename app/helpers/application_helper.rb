module ApplicationHelper
  def all(type)
    case type
    when :bands
      klass = "Band".constantize
      method = :band_url
    when :albums
      klass = "Album".constantize
      method = :album_url
    when :tracks
      klass = "Track".constantize
      method = :track_url
    else
      raise "Type not defined"
    end

    html = ""
    all_info = klass.send(:all)
    all_info.each do |entry|
      url = send(method, [entry])
      html += "<p>" + link_to(h(entry.name), url) + "</p>"
    end
    html.html_safe
  end
end
