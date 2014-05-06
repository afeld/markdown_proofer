require 'rubygems'
require 'bundler'
Bundler.require(:default)

require 'markdown_proofer/version'
require 'markdown_proofer/rake_task'
require 'find'
require 'html/pipeline'
require 'html/proofer'


class MarkdownProofer
  attr_reader :path, :options, :errors, :pipeline

  def initialize(path, options={})
    @path = path
    @options = options.dup
    self.options[:html_proofer] ||= {}

    self.reset_errors
    @pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::TableOfContentsFilter
    ], gfm: true
  end

  def files
    if File.file?(self.path)
      [self.path]
    else # directory
      pattern = File.join(self.path, '**', '*.md')
      Dir.glob(pattern)
    end
  end

  def run
    self.reset_errors

    # iterate over files, and generate HTML from Markdown
    self.files.each do |file|
      # convert the Markdown to HTML
      contents = File.read(file)
      result = self.pipeline.call(contents)

      # save the HTML file next to the Markdown one
      output_file = file.sub(/\.md$/, '.html')
      begin
        File.open(output_file, 'w') do |file|
          file.write(result[:output].to_s)
        end

        # do validation on the file
        html_proofer = HTML::Proofer.new(output_file, self.options[:html_proofer])
        output = self.capture_stderr { html_proofer.run }
        errors = output.split("\n")
        self.errors.concat(errors)
      ensure
        # clean up the file
        FileUtils.rm(output_file)
      end
    end

    self.errors.empty?
  end


  protected

  def reset_errors
    @errors = []
  end

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
      $stdout = original_stdout
    end
    fake_err.string
  end
end
