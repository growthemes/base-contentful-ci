PROJECT ?= grow-ci
BUCKET ?= grow-ci
GITHUB_USERNAME ?= growthemes
GITHUB_REPO ?= base-contentful-ci
GITHUB_ACCESS_TOKEN ?=
GITHUB_COMMIT ?=
DEPLOY_URL = http://$(BUCKET).storage.googleapis.com/index.html

deploy:
	grow build
	gsutil mb -p $(PROJECT) gs://$(BUCKET) || echo "Bucket exists."
	gsutil defacl set public-read gs://$(BUCKET)
	gsutil web set -m index.html -e 404.html gs://$(BUCKET) || echo "Website configured."
	gsutil -m rsync -R build gs://$(BUCKET)

update-commit-status:
	curl "https://api.github.com/repos/$(GITHUB_USERNAME)/$(GITHUB_REPO)/statuses/$(GITHUB_COMMIT)" \
	    -H "Content-Type: application/json" \
	    -H "Authorization: token $(GITHUB_ACCESS_TOKEN)" \
	    -X POST \
	    -d "{\"state\": \"success\", \"context\": \"grow\", \"description\": \"Preview: $(DEPLOY_URL)\", \"target_url\": \"$(DEPLOY_URL)\"}"
