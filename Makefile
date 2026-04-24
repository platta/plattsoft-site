.PHONY: install sync check serve

install:
	cd docs && bundle install

sync:
	script/sync-github-pages

check:
	@script/check-github-pages-versions

serve: check
	cd docs && bundle exec jekyll serve --host 0.0.0.0
