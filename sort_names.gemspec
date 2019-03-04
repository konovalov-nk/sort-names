lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sort-names/version'

Gem::Specification.new do |spec|
  spec.name          = 'sort_names'
  spec.version       = SortNames::VERSION
  spec.authors       = ['Nikolay Konovalov']
  spec.email         = ['konovalov.nk@gmail.com']

  spec.summary       = 'Algorithm to sort files using k-merge sort'
  spec.homepage      = 'https://github.com/konovalov-nk/sort-names'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables = ["sort_names"]
  spec.require_paths = ['lib']

  spec.add_dependency 'slop', '~> 4.2.1'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'guard-rspec', '~> 4.7.3'
  spec.add_development_dependency 'rake', '~> 12.3.2'
  spec.add_development_dependency 'rspec', '~> 3.8.0'
  spec.add_development_dependency 'rubocop', '~> 0.64.0'
end
