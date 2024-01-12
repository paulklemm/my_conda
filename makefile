VERSION=0.2
DOCKERHUB_USER=paulklemm
SERVER=pklemm@blade27.sf.mpg.de
SINGULARITY_PATH=/beegfs/scratch/bruening_scratch/pklemm/singularity/singularity-images
SINGULARITY_LATEST_PATH=$(SINGULARITY_PATH)/latest

.PHONY: all
all: build singularity copy create-link clean

build:
	docker build -t my_conda .
	docker tag my_conda $(DOCKERHUB_USER)/my_conda:$(VERSION)
	docker push $(DOCKERHUB_USER)/my_conda:$(VERSION)

singularity:
	docker run --rm -v ${PWD}:/my_conda -it quay.io/singularity/singularity:v3.11.4-arm64 build /my_conda/my_conda_$(VERSION).simg docker://paulklemm/my_conda:$(VERSION)

copy:
	scp ${PWD}/my_conda_$(VERSION).simg $(SERVER):$(SINGULARITY_PATH)

create-link:
	ssh $(SERVER) "ln -s $(SINGULARITY_PATH)/my_conda_$(VERSION).simg $(SINGULARITY_LATEST_PATH)/my_conda.simg"

clean:
	rm -f my_conda_$(VERSION).simg
