.PHONY: css css-watch build serve dev

css:
	tailwindcss -i ./assets/css/app.css -o ./assets/css/main.css

css-watch:
	tailwindcss -i ./assets/css/app.css -o ./assets/css/main.css --watch

build: css
	hugo --minify

serve:
	hugo server --disableFastRender

dev:
	nix develop -c hugo server --source demo --disableFastRender
