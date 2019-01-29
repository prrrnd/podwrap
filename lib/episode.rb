module Podwrap
  class Episode
    MAPPING = {
      title: [:title],
      description: [:content_encoded, :content, :description, :itunes_summary],
      published_at: [:pubDate, :published, :dc_date, :issued],
      explicit: [:explicit, :itunes_explicit],
      keywords: [:keywords, :itunes_keywords],
      track: [:enclosure]
    }.freeze

    attr_accessor(*MAPPING.keys.freeze)

    def track=(value)
      @track = value&.url
    end

    def explicit=(value)
      @explicit = value == "yes" || false
    end
  end
end
