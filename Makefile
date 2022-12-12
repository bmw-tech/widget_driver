.DEFAULT_GOAL    := help

clean:	##  Clean all the cache and dependencies from dart modules.
	bash scripts/run-clean.sh

prepare: clean ## Prepare the project for development
	bash scripts/run-prepare.sh

format: 
	dart format -l 120 .

lint: clean prepare ## Run flutter lint in all projects
	bash scripts/run-flutter-lint.sh

build_ios: clean prepare  ## Run the iOS build without deploying to any device
	bash scripts/run-ios-build.sh

build_android: clean prepare ## Run the Android build without deploying to any device
	bash scripts/run-android-build.sh

test: prepare ## Run all tests in all projects
	bash scripts/run-tests.sh

quality: ## Run only linter and tests
	bash scripts/run-clean.sh
	bash scripts/run-prepare.sh
	bash scripts/run-flutter-lint.sh
	bash scripts/run-tests.sh

full: ## Runs all steps including building the Android and iOS
	bash scripts/run-clean.sh
	bash scripts/run-prepare.sh
	bash scripts/run-flutter-lint.sh
	bash scripts/run-tests.sh
	bash scripts/run-ios-build.sh
	bash scripts/run-android-build.sh

help: ## Show all commands
	@grep '^[^#[:space:]].*:' Makefile
