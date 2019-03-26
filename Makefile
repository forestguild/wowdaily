build:
	rm -f ./*.gem
	gem build jekyll-wowdaily.gemspec

push:
	gem push ./*.gem

