.PHONY: dev
dev:
	hugo --source demo --destination public --cleanDestinationDir -b http://127.0.0.1:1414/
	pagefind --site demo/public --force-language en --silent
	@trap 'kill $$hugo_pid $$pagefind_pid 2>/dev/null' INT TERM EXIT; \
	hugo server --source demo --destination public --disableFastRender -b http://127.0.0.1:1414/ --port 1414 & \
	hugo_pid=$$!; \
	watchexec --postpone --watch demo/content --watch demo/hugo.yaml --watch layouts --watch assets --watch static --watch config --debounce 1sec --delay-run 500ms -- pagefind --site demo/public --force-language en --silent & \
	pagefind_pid=$$!; \
	wait $$hugo_pid

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
