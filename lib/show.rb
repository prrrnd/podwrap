module Podwrap
  class Show
    MAPPING = {
      title: [:title],
      language: [:language],
      description: [:content_encoded, :content, :description],
      cover: [:itunes_image, :image],
      category: [:itunes_category],
      author: [:author, :itunes_author],
    }.freeze

    attr_accessor(*MAPPING.keys.freeze)
    attr_accessor :episodes

    def cover=(value)
      case value.class.to_s
      when "RSS::ITunesChannelModel::ITunesImage"
        @cover = value&.href
      else
        @cover = value&.url
      end
    end

    def category=(value)
      @category = value&.text
    end
  end
end
