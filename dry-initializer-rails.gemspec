Gem::Specification.new do |gem|
  gem.name     = "dry-initializer-rails"
  gem.version  = "1.0.0"
  gem.author   = ["Vladimir Kochnev (marshall-lee)", "Andrew Kozin (nepalez)"]
  gem.email    = ["hashtable@yandex.ru", "andrew.kozin@gmail.com"]
  gem.homepage = "https://github.com/nepalez/dry-initializer-rails"
  gem.summary  = "Adds ActiveRecord-specific methods to Dry::Initializer"
  gem.license  = "MIT"

  gem.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files       = gem.files.grep(/^spec/)
  gem.extra_rdoc_files = Dir["README.md", "LICENSE", "CHANGELOG.md"]

  gem.required_ruby_version = ">= 2.2.2"

  gem.add_runtime_dependency "rails", "> 3.0"
  gem.add_runtime_dependency "dry-initializer", "~> 1.1"

  gem.add_development_dependency "rspec", "~> 3.0"
  gem.add_development_dependency "rake", "> 10.0"
  gem.add_development_dependency "sqlite3", "~> 1.3"
  gem.add_development_dependency "database_cleaner", "~> 1.5"
  gem.add_development_dependency "rubocop", "~> 0.44"
end
