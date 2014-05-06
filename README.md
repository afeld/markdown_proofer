# MarkdownProofer

[foo](http://broke.nnsss)

A gem that validates your Markdown files.  It uses [html-proofer](https://github.com/gjtorikian/html-proofer) under the hood to check whether links and images exist.

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

and if you want to run the validation using [Travis CI](https://travis-ci.org), include

```yaml
# .travis.yml

language: ruby
rvm:
  - 2.0.0
install: bundle install --deployment --path .bundle
```

## Running

```bash
bundle
bundle exec rake
```
