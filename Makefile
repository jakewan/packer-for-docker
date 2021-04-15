publish:
	docker login --username frostedcarbon && cd src/packer && packer build .
