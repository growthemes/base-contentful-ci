project ?= 'grow-ci'
bucket ?= 'grow-demo-ci'

deploy:
	grow build
	gsutil mb \
	  -p $(project) \
	  gs://$(bucket) || echo "Bucket exists."
	gsutil web \
	  set \
	  -m index.html \
	  -e 404.html \
	  gs://$(bucket) || echo "Website configured."
	gsutil -m \
	  cp -r \
	  build/* \
	  gs://$(bucket)
