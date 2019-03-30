SRC = proj
VERSION = test
ARTS = $(SRC)-$(VERSION).zip

build: $(SRC)
	zip -r $(ARTS) $(SRC)
	unzip -l $(ARTS)

clean: $(ARTS)
	rm -rf $(ARTS) 
