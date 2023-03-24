default:
	@echo "" > /dev/null

build_runner:
	@cd packages/directus_core; dart run build_runner watch
dcu:
	@docker-compose up
run_example:
	@cd packages/directus_core/example; dart run