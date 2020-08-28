css:
	npx postcss templates/*.css -o static/styles.css

serve:
	zola serve

build:
	zola build --output-dir docs
