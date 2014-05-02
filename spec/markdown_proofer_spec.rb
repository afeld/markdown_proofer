require 'spec_helper'

describe MarkdownProofer do
  it "has a version number" do
    expect(MarkdownProofer::VERSION).not_to be nil
  end

  describe '#files' do
    it "handles directories" do
      proofer = MarkdownProofer.new(fixture_path)
      files = proofer.files
      expect(files.size).to eq(2)
      expect(files.first).to end_with('/spec/fixtures/broken_link.md')
    end

    it "handles files" do
      proofer = MarkdownProofer.new(fixture_path('broken_link.md'))
      files = proofer.files
      expect(files.size).to eq(1)
      expect(files.first).to end_with('/spec/fixtures/broken_link.md')
    end
  end

  describe '#run' do
    it "complains for files with broken links" do
      proofer = MarkdownProofer.new(fixture_path)
      proofer.run
      expect(proofer.errors.size).to eq(1)
      expect(proofer.errors.first).to include("External link")
    end

    it "returns true for no broken links" do
      proofer = MarkdownProofer.new(fixture_path('working_link.md'))
      expect(proofer.run).to be_true
    end

    it "returns false for broken links" do
      proofer = MarkdownProofer.new(fixture_path)
      expect(proofer.run).to be_false
    end

    it "can be executed multiple times" do
      proofer = MarkdownProofer.new(fixture_path)
      2.times do
        proofer.run
        expect(proofer.errors.size).to eq(1)
      end
    end
  end
end
