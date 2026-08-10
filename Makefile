SHELL := /bin/bash

.PHONY: dev
dev: css
	hugo --source demo --destination public --cleanDestinationDir -b http://127.0.0.1:1414/
	pagefind --site demo/public --silent
	@set -u; \
	cleanup() { \
		trap - EXIT INT TERM; \
		kill $$hugo_pid $$pagefind_pid $$css_pid 2>/dev/null || true; \
		wait $$hugo_pid $$pagefind_pid $$css_pid 2>/dev/null || true; \
	}; \
	trap cleanup EXIT; \
	trap 'exit 130' INT; \
	trap 'exit 143' TERM; \
	hugo server --source demo --destination public --disableFastRender -b http://127.0.0.1:1414/ --port 1414 & \
	hugo_pid=$$!; \
	watchexec --postpone --watch demo/public --ignore 'demo/public/pagefind/**' --debounce 1sec -- pagefind --site demo/public --silent & \
	pagefind_pid=$$!; \
	tailwindcss -i ./assets/css/app.css -o ./assets/css/main.css --watch=always & \
	css_pid=$$!; \
	set +e; \
	wait -n $$hugo_pid $$pagefind_pid $$css_pid; \
	status=$$?; \
	set -e; \
	if [ $$status -eq 0 ]; then \
		echo "A development watcher exited unexpectedly" >&2; \
		exit 1; \
	fi; \
	exit $$status

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
	pagefind --site public
