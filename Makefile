GITBOOK = $(CURDIR)/gitbook
DOCS = $(CURDIR)/docs
IMAGE_ENV = $(CURDIR)/image
DF = $(IMAGE_ENV)/Dockerfile
DEPLOYMENT = $(CURDIR)/deployment
OWNER = [OWNER]
REPO = [REPO]

.PHONY: mk-book clean-book
mk-book: $(GITBOOK)
	gitbook build $(GITBOOK) $(DOCS)

clean-book:
	rm -rf $(DOCS)/*

.PHONY: mk-image clean-image
mk-image:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset
	docker build -t $(OWNER)/$(REPO)-$(ARCH) -f $(DF)-$(ARCH) $(IMAGE_ENV) 

clean-image:
	docker rmi $(OWNER)/$(REPO)-$(ARCH)


.PHONY: mk-deployment clean-deployment

DEPLOYMENT_x86=$(DEPLOYMENT)/imageAPI-x86
DEPLOYMENT_armv6=$(DEPLOYMENT)/imageAPI-armv6

mk-deployment-x86: $(DEPLOYMENT_x86)
	sed -i s+VERSION=latest.*+VERSION=$(VERSION)+g $(DEPLOYMENT_x86)/temp.env
	mkdir imageAPI 
	cp $(DEPLOYMENT_x86)/docker-compose.yml $(DEPLOYMENT_x86)/temp.env $(DEPLOYMENT_x86)/Makefile imageAPI/
	zip -r $(REPO)-$(VERSION).zip imageAPI
	rm -rf imageAPI

mk-deployment-armv6: $(DEPLOYMENT_armv6)
	sed -i s+VERSION=latest.*+VERSION=$(VERSION)+g $(DEPLOYMENT_armv6)/temp.env
	mkdir imageAPI 
	cp $(DEPLOYMENT_armv6)/docker-compose.yml $(DEPLOYMENT_armv6)/temp.env $(DEPLOYMENT_armv6)/Makefile imageAPI/
	zip -r $(REPO)-$(VERSION).zip imageAPI
	rm -rf imageAPI

mk-deployment: mk-deployment-x86 mk-deployment-armv6

clean-deployment: $(REPO)-$(VERSION).zip
	rm $(REPO)-$(VERSION).zip


.PHONY: pushtohub
pushtohub:
	docker tag $(OWNER)/$(REPO)-$(ARCH) $(OWNER)/$(REPO)-$(ARCH):$(TAG)
	docker login -u $(USER) -p $(PASS)
	docker push $(OWNER)/$(REPO)-$(ARCH):$(TAG)
