class MarkdownProofer
  module RakeTask
    def create_proofer(*args)
      args[0] ||= {}
      args[0][:excludes] ||= [
        /\bfixtures\//,
        /\bspec\//,
        /\btext\//,
        /\bvendor\//
      ]
      MarkdownProofer.new(*args)
    end
    module_function :create_proofer

    def run(*args)
      puts "Validating Markdown..."
      proofer = self.create_proofer(*args)
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
