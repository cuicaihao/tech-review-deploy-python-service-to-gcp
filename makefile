.PHONY: clean data lint requirements 

#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BUCKET = [OPTIONAL] your-bucket-for-syncing-data (do not include 's3://')
PROFILE = default
PROJECT_NAME = google-cloud-build-to-deploy-services
PYTHON_INTERPRETER = python3

 
#################################################################################
# COMMANDS                                                                      #
#################################################################################

## Step 1: Create python virtual environment
s1_create_environment:
	$(PYTHON_INTERPRETER) -m venv .venv

## Step 2: Install requirements
s2_requirements:
	source .venv/bin/activate &&  pip install --no-cache-dir -r hello_app/requirements.txt

## Step 3: Local Test
s3_test:
	source .venv/bin/activate && python hello_app/test.py

## Step 4: Local Run
s4_local_run:
	source .venv/bin/activate && python hello_app/main.py
	 
## Step 5: Deploy the Model to App Engine from Source
s5_deploy_to_app_engine_from_source:
	cd hello_app && gcloud app deploy app.yaml --quiet
	
## Step 6: Deploy the Model to Cloud Run from Source
s6_deploy_to_cloud_run_from_source:
	cd hello_app && gcloud run deploy hello-app --source=. --platform=managed 

## Step 7: Local docker build and run
s7_local_docker_build_and_run:
	docker build . -t hello-app:latest 
	docker run -p 8080:8080 hello-app:latest

## step 8: Deploy to App Engine using docker
s8_deploy_to_app_engine_using_docker:
	cd hello_app && gcloud app deploy app.flexible.yaml --quiet

## step 9: Deploy to Cloud Run using docker
s9_deploy_to_cloud_run_using_docker:
	bash cloud_run.sh

#################################################################################
# PROJECT RULES                                                                 #
#################################################################################


#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: help
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')
