VERSION=0.2
DOCKERHUB_USER=paulklemm

all: build singularity

build:
	docker build -t my_conda .
	docker tag my_conda $(DOCKERHUB_USER)/my_conda:$(VERSION)
	docker push $(DOCKERHUB_USER)/my_conda:$(VERSION)

singularity:
	docker run --rm -v ${PWD}:/my_conda -it quay.io/singularity/singularity:v3.11.4-arm64 build /my_conda/my_conda_$(VERSION).simg docker://paulklemm/my_conda:$(VERSION)
