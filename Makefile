project ?= 'grow-ci'
bucket ?= 'grow-demo-ci'

deploy:
	grow build
	gsutil mb -p $(project) gs://$(bucket) || echo "Bucket exists."
	gsutil defacl set public-read gs://$(bucket)
	gsutil web set -m index.html -e 404.html gs://$(bucket) || echo "Website configured."
	gsutil -m rsync -R build gs://$(bucket)
