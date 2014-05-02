require 'rubygems'
require 'bundler/setup'

require 'markdown_proofer/version'
require 'find'
require 'html/pipeline'
require 'html/proofer'

class MarkdownProofer
  attr_reader :path, :errors, :pipeline

  def initialize(path)
    @path = path
    @errors = []
    @pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::TableOfContentsFilter
    ], gfm: true
  end

  def files
    pattern = File.join(self.path, '**', '*.md')
    Dir.glob(pattern)
  end

  def run
    # iterate over files, and generate HTML from Markdown
    self.files.each do |file|
      # convert the Markdown to HTML
      contents = File.read(file)
      result = self.pipeline.call(contents)

      # save the HTML file next to the Markdown one
      output_file = file.sub(/\.md$/, '.html')
      File.open(output_file, 'w') do |file|
        file.write(result[:output].to_s)
      end

      # do validation on the file
      html_proofer = HTML::Proofer.new(output_file)
      output = self.capture_stderr { html_proofer.run }
      errors = output.split("\n")
      @errors.concat(errors)

      # clean up the file
      FileUtils.rm(output_file)
    end
  end


  protected

  # https://github.com/gjtorikian/html-proofer/blob/f16643845ed26c5aaeafc7c6c8d69a00e2acad75/spec/spec_helper.rb#L17
  def capture_stderr(&block)
    original_stderr = $stderr
    original_stdout = $stdout
    $stderr = fake_err = StringIO.new
    $stdout = fake_out = StringIO.new
    begin
      yield
    rescue RuntimeError
    ensure
      $stderr = original_stderr
      # $stdout = original_stdout
    end
    fake_err.string
  end
end
