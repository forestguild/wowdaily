Gem::Specification.new do |s|
    s.name        = 'jekyll-wowdaily'
    s.version     = '1.0.0'
    s.date        = '2018-11-29'
    s.summary     = "WoW Daily from wowhead"
    s.description = "Parse 'Today in WoW' data from Wowhead to jekyll's data file"
    s.authors     = ["Nikita Chernyi"]
    s.email       = 'github@rakshazi.me'
    s.files       = `git ls-files`.split($INPUT_RECORD_SEPARATOR).grep(%r!^lib/!)
    s.require_paths = %w(lib)
    s.homepage    = 'https://github.com/rakshazi/jekyll-wowdaily'
    s.license     = 'MIT'
    s.metadata = {
        "bug_tracker_uri"   => "https://github.com/rakshazi/jekyll-wowdaily",
        "changelog_uri"     => "https://github.com/rakshazi/jekyll-wowdaily/releases",
        "documentation_uri" => "https://github.com/rakshazi/jekyll-wowdaily/blob/master/README.md",
        "homepage_uri"      => "https://github.com/rakshazi/jekyll-wowdaily",
        "source_code_uri"   => "https://github.com/rakshazi/jekyll-wowdaily",
    }
    s.required_ruby_version = '>=2.0.0'
    s.add_runtime_dependency 'jekyll', '~> 3.8.5', '>=3.0.0'
    s.add_runtime_dependency 'nokogiri', '~> 1.10.1', '>=1.0.0'
end
