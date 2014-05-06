class MarkdownProofer
  module RakeTask
    def run(*args)
      puts "Validating Markdown..."
      proofer = MarkdownProofer.new(*args)
      proofer.run
      if proofer.errors.any?
        raise "Failed! #{proofer.errors.join("\n")}"
      else
        puts "Success!"
      end
    end
    module_function :run
  end
end
