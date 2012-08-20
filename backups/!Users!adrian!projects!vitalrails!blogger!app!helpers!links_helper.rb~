module LinksHelper
  def tag_links(tags)
    tags.map { |tag| link_to tag.name, tag_path(tag) }.join(", ").html_safe
  end
end
