PROJECT ?= grow-ci
BUCKET ?= grow-ci
GITHUB_USERNAME ?= growthemes
GITHUB_REPO ?= base-contentful-ci
GITHUB_ACCESS_TOKEN ?=
GITHUB_COMMIT ?=

deploy:
	grow build
	gsutil mb -p $(PROJECT) gs://$(BUCKET) || echo "Bucket exists."
	gsutil defacl set public-read gs://$(BUCKET)
	gsutil web set -m index.html -e 404.html gs://$(BUCKET) || echo "Website configured."
	gsutil -m rsync -R build gs://$(BUCKET)

update-commit-status:
	curl "https://api.github.com/repos/$(GITHUB_USERNAME)/$(GITHUB_REPO)/statuses/$(GITHUB_COMMIT)?access_token=$(GITHUB_ACCESS_TOKEN)" \
	    -H "Content-Type: application/json" \
	    -X POST \
	    -d "{\"state\": \"success\", \"description\": \"Grow\", \"target_url\": \"http://$(BUCKET).storage.googleapis.com/index.html\"}"
