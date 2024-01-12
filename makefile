VERSION=0.2
DOCKERHUB_USER=paulklemm

build:
	docker build -t my_conda .
	docker tag my_conda $(DOCKERHUB_USER)/my_conda:$(VERSION)
	docker push $(DOCKERHUB_USER)/my_conda:$(VERSION)
