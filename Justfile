css:
	npx tailwindcss build templates/styles.css -o static/styles.css

serve:
	zola serve

build:
	zola build --output-dir docs
