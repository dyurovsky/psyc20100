REMOTEUSER ?= yurovsky
REMOTEHOST ?= webspace.uchicago.edu
REMOTEDIR ?= /public_html/courses/autumn2016/psc20100
REMOTE ?= $(REMOTEUSER)@$(REMOTEHOST):$(REMOTEDIR)

.PHONY: clean
clean:
	rm -rf _site/*

push: build
	rsync -az _site/* $(REMOTE)

build:
	jekyll build --incremental

serve:
	jekyll serve --watch --baseurl ''