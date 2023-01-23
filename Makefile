.DEFAULT_GOAL    := help

publish: ## publish all projects to pub.dev
	bash scripts/run-publish.sh

example_run_build_runner: ## Generate code for the example app inside the widget_driver folder.
	bash scripts/run-example-run-build-runner.sh
	make format

clean:	## Clean all the cache and dependencies from dart modules.
	bash scripts/run-clean.sh

install: ## Fetch all dependencies for all packages
	bash scripts/run-install.sh

format: ## Format all Dart files in the project with the line length set to 120
	dart format -l 120 .

lint: ## Run flutter lint in all projects
	bash scripts/run-flutter-lint.sh

test: ## Run all tests in all projects
	bash scripts/run-tests.sh

build_ios: install ## Run the iOS build of the example app (located inside `widget_driver/example`) without deploying to any device
	bash scripts/run-ios-build.sh

build_android: install ## Run the Android build of the example app (located inside `widget_driver/example`) without deploying to any device
	bash scripts/run-android-build.sh

watch: install ## Starts the example app and performs the hot reload in case of any change
	bash scripts/run-and-watch.sh

quality: clean install lint test ## Run only linter and tests

build: install build_ios build_android ## Build the example Android and iOS apps from the widget_driver package

all: clean install lint test build_ios build_android ## Run all steps including building the Android and iOS

help: ## Show all commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
