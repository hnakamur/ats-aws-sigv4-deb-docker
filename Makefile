PKG_ARCHIVE_NAME=ats-aws-sigv4
PKG_VERSION=0.4.0
PKG_REL_PREFIX=1hn1
ifdef NO_CACHE
DOCKER_NO_CACHE=--no-cache
endif

# Debian 13
deb-debian13: build-debian13
	docker run --rm -v ./${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}debian13:/dist ${PKG_ARCHIVE_NAME}-debian13 bash -c \
	"install /src/*${PKG_VERSION}* /dist/"
	tar zcf ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}debian13.tar.gz ./${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}debian13/

build-debian13:
	mkdir -p ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}debian13
	PKG_REL_DISTRIB=debian13; \
	(set -x; \
	docker buildx build --load --progress=plain ${DOCKER_NO_CACHE} \
		--build-arg FROM=debian:13 \
		--build-arg PKG_VERSION=${PKG_VERSION} \
		--build-arg PKG_REL_DISTRIB=debian13 \
		-t ${PKG_ARCHIVE_NAME}-debian13 . \
	) 2>&1 | tee ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}debian13/${PKG_ARCHIVE_NAME}_${PKG_VERSION}-${PKG_REL_PREFIX}$${PKG_REL_DISTRIB}.build.log&& \
	xz -9 --force ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}debian13/${PKG_ARCHIVE_NAME}_${PKG_VERSION}-${PKG_REL_PREFIX}$${PKG_REL_DISTRIB}.build.log

run-ubuntu2604:
	docker run --rm -it ${PKG_ARCHIVE_NAME}-ubuntu2604 bash

.PHONY: deb-debian13 run-debian13 build-debian13

# Ubuntu 26.04
deb-ubuntu2604: build-ubuntu2604
	docker run --rm -v ./${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu26.04:/dist ${PKG_ARCHIVE_NAME}-ubuntu2604 bash -c \
	"install /src/*${PKG_VERSION}* /dist/"
	tar zcf ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu26.04.tar.gz ./${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu26.04/

build-ubuntu2604:
	mkdir -p ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu26.04
	PKG_REL_DISTRIB=ubuntu26.04; \
	(set -x; \
	docker buildx build --load --progress=plain ${DOCKER_NO_CACHE} \
		--build-arg FROM=ubuntu:26.04 \
		--build-arg PKG_VERSION=${PKG_VERSION} \
		--build-arg PKG_REL_DISTRIB=ubuntu26.04 \
		-t ${PKG_ARCHIVE_NAME}-ubuntu2604 . \
	) 2>&1 | tee ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu26.04/${PKG_ARCHIVE_NAME}_${PKG_VERSION}-${PKG_REL_PREFIX}$${PKG_REL_DISTRIB}.build.log&& \
	xz -9 --force ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu26.04/${PKG_ARCHIVE_NAME}_${PKG_VERSION}-${PKG_REL_PREFIX}$${PKG_REL_DISTRIB}.build.log

run-ubuntu2604:
	docker run --rm -it ${PKG_ARCHIVE_NAME}-ubuntu2604 bash

.PHONY: deb-ubuntu2604 run-ubuntu2604 build-ubuntu2604

# Ubuntu 22.04
deb-ubuntu2204: build-ubuntu2204
	docker run --rm -v ./${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04:/dist ${PKG_ARCHIVE_NAME}-ubuntu2204 bash -c \
	"install /src/*${PKG_VERSION}* /dist/"
	tar zcf ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04.tar.gz ./${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04/

build-ubuntu2204:
	mkdir -p ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04
	PKG_REL_DISTRIB=ubuntu22.04; \
	(set -x; \
	docker buildx build --load --progress=plain ${DOCKER_NO_CACHE} \
		--build-arg FROM=ubuntu:22.04 \
		--build-arg PKG_VERSION=${PKG_VERSION} \
		--build-arg PKG_REL_DISTRIB=ubuntu22.04 \
		-t ${PKG_ARCHIVE_NAME}-ubuntu2204 . \
	) 2>&1 | tee ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04/${PKG_ARCHIVE_NAME}_${PKG_VERSION}-${PKG_REL_PREFIX}$${PKG_REL_DISTRIB}.build.log&& \
	xz -9 --force ${PKG_ARCHIVE_NAME}-${PKG_VERSION}-${PKG_REL_PREFIX}ubuntu22.04/${PKG_ARCHIVE_NAME}_${PKG_VERSION}-${PKG_REL_PREFIX}$${PKG_REL_DISTRIB}.build.log

run-ubuntu2204:
	docker run --rm -it ${PKG_ARCHIVE_NAME}-ubuntu2204 bash

.PHONY: deb-ubuntu2204 run-ubuntu2204 build-ubuntu2204

exec:
	docker exec -it $$(docker ps -q) bash

.PHONY: exec
