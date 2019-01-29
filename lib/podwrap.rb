require "podwrap/version"

require "rss"

require_relative "show"
require_relative "episode"

module Podwrap
  class Error < StandardError; end

  class Parser
    attr_reader :rss, :xml

    def initialize(xml)
      @xml = xml
      @rss = RSS::Parser.parse(xml)
    end

    def build
      show = build_show(rss.channel)
      show.episodes = build_episodes(rss.channel.items)
      show
    end

    private

    def build_show(channel)
      show = ::Podwrap::Show.new
      ::Podwrap::Show::MAPPING.each do |attr, methods|
        show.send(:"#{attr}=", grab(methods, channel))
      end
      show
    end

    def build_episodes(items)
      items.map do |item|
        episode = ::Podwrap::Episode.new
        ::Podwrap::Episode::MAPPING.each do |attr, methods|
          episode.send(:"#{attr}=", grab(methods, item))
        end
        episode
      end
    end

    def grab(methods, src)
      methods.each do |m|
        if src.respond_to?(m)
          value = src.send(m)
          return value unless value.nil?
        end
      end

      nil
    end
  end
end
