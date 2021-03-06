# MarkdownProofer [![Build Status](https://travis-ci.org/afeld/markdown_proofer.svg?branch=master)](https://travis-ci.org/afeld/markdown_proofer)

A gem that validates your Markdown files.  It uses [HTML::Proofer](https://github.com/gjtorikian/html-proofer) under the hood to check whether links and images exist.

## Setup

Requires Ruby 2.0+.  Create the following files:

```ruby
# Gemfile

source 'https://rubygems.org'

gem 'markdown_proofer', '~> 0.1.1'
gem 'rake'
```

```ruby
# Rakefile

require 'rubygems'
require 'bundler'
Bundler.require(:default)

desc "Run Mardown validation for the repository"
task :validate_markdown do
  MarkdownProofer::RakeTask.run
end

task default: :validate_markdown
```

### Configuration

`MarkdownProofer::RakeTask.run` accepts the following named parameters:

* `excludes` – An Array of regular expressions.  Any file paths that match will be excluded from validation.  Defaults to excluding test-related files.
* `html_proofer` – Options passed to HTML::Proofer.  See [the HTML::Proofer documentation](https://github.com/gjtorikian/html-proofer#configuration).
* `path` – The relative path to the file/directory that you want to validate. Defaults to the top-level directory.

## Usage

```bash
bundle
bundle exec rake
```
