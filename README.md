# MarkdownProofer

A gem that validates your Markdown files.  It uses [HTML::Proofer](https://github.com/gjtorikian/html-proofer) under the hood to check whether links and images exist.

## Setup

Create the following files:

```ruby
# Gemfile

source 'https://rubygems.org'

gem 'markdown_proofer'
gem 'rake'
```

```ruby
# Rakefile

require 'rubygems'
require 'bundler'
Bundler.require(:default)

task :test do
  MarkdownProofer::RakeTask.run
end

task default: :test
```

### Configuration

`MarkdownProofer::RakeTask.run` accepts the following named parameters:

* `path` – The relative path to the file/directory that you want to validate. Defaults to the top-level directory.
* `html_proofer` – Options passed to HTML::Proofer.  See [the HTML::Proofer documentation](https://github.com/gjtorikian/html-proofer#configuration).

### Travis CI

If you want to run the validation using [Travis CI](https://travis-ci.org), include

```yaml
# .travis.yml

language: ruby
rvm:
  - 2.0.0
install: bundle install --deployment --path .bundle
```

## Usage

```bash
bundle
bundle exec rake
```
