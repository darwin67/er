.PHONY: dev
dev:
	hugo server --source demo --disableFastRender

.PHONY: css
css:
	tailwindcss -i ./assets/css/app.css -o ./assets/css/main.css

.PHONY: css-watch
css-watch:
	tailwindcss -i ./assets/css/app.css -o ./assets/css/main.css --watch

.PHONY: build
build: css
	hugo --minify
	$(MAKE) index

.PHONY: index
index:
	pagefind --site public --force-language en
