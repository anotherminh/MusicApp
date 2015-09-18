module ApplicationHelper
  def all(type)
    klass, url = make_class_and_urls(type)
    all_info = klass.constantize.send(:all)
    print_array_as_list(url, all_info)
  end

  def all_albums_of(band)
    albums = Album.where(band_id: band.id)
    print_array_as_list("album_url", albums)
  end

  def all_tracks_of(album)
    tracks = Track.where(album_id: album.id)
    print_array_as_list("track_url", tracks)
  end

  def print_array_as_list(url, ary)
    html = ""
    ary.each do |entry|
      full_url = send(url, [entry])
      html += "<p>" + link_to(h(entry.name), full_url) + "</p>"
    end
    html.html_safe
  end

  def create_new_stuff_button(parent = nil, type, current_obj)
    url = send("new_#{parent}_#{type}_url", current_obj)
    link_to("Enter new #{type}", url)
  end

  def create_edit_button(type, url)
    link_to("Edit #{type}", url)
  end

  def make_class_and_urls(type, index = false)
    case type
    when :bands
      klass = "Band"
      url = index ? :bands_url : :band_url
    when :albums
      klass = "Album"
      url = index ? :albums_url : :album_url
    when :tracks
      klass = "Track"
      url = index ? :tracks_url : :track_url
    else
      raise "Type not defined"
    end

    [klass, url]
  end

  def auth_token
    html = <<-HTML
      <input type="hidden"
           name="authenticity_token"
           value="#{form_authenticity_token}">
    HTML
    html.html_safe
  end
end
