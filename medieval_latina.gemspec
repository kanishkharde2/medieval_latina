require_relative "lib/medieval_latina/version"

Gem::Specification.new do |spec|
  spec.name = "medieval_latina"
  spec.version = MedievalLatina::VERSION
  spec.authors = ["Jayson Virissimo"]
  spec.email = ["jayson.virissimo@asu.edu"]

  spec.summary = "Transform medieval Latin text into phonetic English"
  spec.description = "Transform medieval Latin text into phonetic English..."
  spec.homepage = "https://github.com/jaysonvirissimo/medieval_latina"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jaysonvirissimo/medieval_latina"
  spec.metadata["changelog_uri"] = "https://github.com/jaysonvirissimo/medieval_latina"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
