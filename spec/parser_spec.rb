RSpec.describe Podwrap::Parser do
  let(:fixture) { File.open(File.dirname(__FILE__) + "/fixtures/rss.xml").read }

  describe "#initalize" do
    it "sets @xml" do
      parser = described_class.new(fixture)
      expect(parser.xml).to eq(fixture)
    end

    it "sets @rss" do
      parser = described_class.new(fixture)
      expect(parser.rss).to be_a(RSS::Rss)
    end
  end

  describe "#build" do
    it "returns a Podwrap::Show" do
      show = described_class.new(fixture).build
      expect(show).to be_a(Podwrap::Show)
    end

    it "sets the show attributes" do
      parser = described_class.new(fixture)
      show = parser.build
      expect(show.title).to eq("Changelog Master Feed")
      expect(show.language).to eq("en-us")
      expect(show.description).to match(/feed of all Changelog podcasts/)
      expect(show.cover).to match(/png/)
      expect(show.category).to eq("Technology")
      expect(show.author).to eq("Changelog Media")
    end

    it "sets the episodes attributes" do
      parser = described_class.new(fixture)
      show = parser.build
      episode = show.episodes.first
      expect(episode.title).to match(/dive into deep learning/)
      expect(episode.description).to match(/Fully Connected/)
      expect(episode.published_at).to be_a(Time)
      expect(episode.explicit).to eq(false)
      expect(episode.track).to match(/mp3/)
      expect(episode.keywords).to include("neural networks")
    end
  end
end
