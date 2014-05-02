require 'spec_helper'

describe MarkdownProofer do
  it "has a version number" do
    expect(MarkdownProofer::VERSION).not_to be nil
  end

  describe '#files' do
    it "handles directories" do
      proofer = MarkdownProofer.new(fixture_path)
      files = proofer.files
      expect(files.size).to eq(1)
      expect(files.first).to end_with('/spec/fixtures/broken_link.md')
    end

    xit "handles files" do
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
  end
end
