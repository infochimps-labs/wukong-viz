# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wukong-viz/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'wukong-viz'
  gem.homepage    = 'https://github.com/infochimps-labs/wukong-viz'
  gem.licenses    = ["Apache 2.0"]
  gem.email       = 'coders@infochimps.com'
  gem.authors     = ['Infochimps', 'Philip (flip) Kromer', 'Travis Dempsey', 'Dhruv Bansal']
  gem.version     = Wukong::Viz::VERSION

  gem.summary     = 'Helps visualize dataflows.'
  gem.description = <<-EOF
Lets you produce intermediate representations of dataflows that are
useful for visualization and other kinds of static analysis.
EOF

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = ['wu-viz']
  gem.test_files    = gem.files.grep(/^spec/)
  gem.require_paths = ['lib']

  gem.add_dependency('wukong',      '3.0.0')
end
