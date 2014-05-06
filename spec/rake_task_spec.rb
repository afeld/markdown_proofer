require 'spec_helper'

describe MarkdownProofer::RakeTask do
  describe '.create_proofer' do
    it "excludes vendor/ and spec/ folders by default" do
      proofer = MarkdownProofer::RakeTask.create_proofer
      expect(proofer.included_files.sort).to eq(['./CONTRIBUTING.md', './README.md'])
    end
  end
end
