# Copyright 2017 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

all: aws/efs ceph/cephfs ceph/rbd flex gluster/block gluster/glusterfs iscsi/targetd local-volume/provisioner local-volume/bootstrapper nfs-client nfs snapshot openstack/standalone-cinder
.PHONY: all

clean: clean-aws/efs clean-ceph/cephfs clean-ceph/rbd clean-flex clean-gluster/block clean-gluster/glusterfs clean-iscsi/targetd clean-local-volume/provisioner clean-local-volume/bootstrapper clean-nfs-client clean-nfs clean-openebs clean-snapshot clean-openstack/standalone-cinder
.PHONY: clean


test: test-aws/efs test-local-volume/provisioner test-nfs test-snapshot test-openstack/standalone-cinder
.PHONY: test

verify:
	repo-infra/verify/verify-go-src.sh -v
	repo-infra/verify/verify-boilerplate.sh
.PHONY: verify

aws/efs:
	cd aws/efs; \
	make container
.PHONY: aws/efs

test-aws/efs:
	cd aws/efs; \
	make test
.PHONY: test-aws/efs

clean-aws/efs:
	cd aws/efs; \
	make clean
.PHONY: clean-aws/efs

ceph/cephfs:
	cd ceph/cephfs; \
	make container
.PHONY: ceph/cephfs

clean-ceph/cephfs:
	cd ceph/cephfs; \
	rm -f cephfs-provisioner
.PHONY: clean-ceph/cephfs

ceph/rbd:
	cd ceph/rbd; \
	make container
.PHONY: ceph/rbd

clean-ceph/rbd:
	cd ceph/rbd; \
	rm -f rbd-provisioner
.PHONY: clean-ceph/rbd

flex:
	cd flex; \
	make container
.PHONY: flex

clean-flex:
	cd flex; \
	make clean
.PHONY: clean-flex

gluster/block:
	cd gluster/block; \
	make container
.PHONY: gluster/block

clean-gluster/block:
	cd gluster/block; \
	make clean
.PHONY: clean-gluster/block

gluster/glusterfs:
	cd gluster/glusterfs; \
	make container
.PHONY: gluster/glusterfs

clean-gluster/glusterfs:
	cd gluster/glusterfs; \
	make clean
.PHONY: clean-gluster/glusterfs

iscsi/targetd:
	cd iscsi/targetd; \
	make container
.PHONY: iscsi/targetd

test-iscsi/targetd:
	cd iscsi/targetd; \
	go test ./...
.PHONY: test-iscsi/targetd

clean-iscsi/targetd:
	cd iscsi/targetd; \
	make clean
.PHONY: clean-iscsi/targetd

local-volume/provisioner:
	cd local-volume/provisioner; \
	make container
.PHONY: local-volume/provisioner

test-local-volume/provisioner:
	cd local-volume/provisioner; \
	go test ./...
.PHONY: test-local-volume/provisioner

clean-local-volume/provisioner:
	cd local-volume/provisioner; \
	make clean
.PHONY: clean-local-volume/provisioner

clean-local-volume/bootstrapper:
	cd local-volume/bootstrapper; \
	make clean
.PHONY: clean-local-volume/bootstrapper

nfs-client:
	cd nfs-client; \
	make container
.PHONY: nfs-client

clean-nfs-client:
	cd nfs-client; \
	rm -f nfs-client-provisioner
.PHONY: clean-nfs-client

nfs: 
	cd nfs; \
	make container
.PHONY: nfs

test-nfs: 
	cd nfs; \
	make test
.PHONY: test-nfs

clean-nfs:
	cd nfs; \
	make clean
.PHONY: clean-nfs

openebs:
	cd openebs; \
	make build
.PHONY: openebs

clean-openebs:
	cd openebs; \
	make clean
.PHONY: clean-openebs

snapshot:
	cd snapshot; \
	make
.PHONY: snapshot

clean-snapshot:
	cd snapshot; \
	make clean
.PHONY: clean-snapshot

openstack/standalone-cinder:
	cd openstack/standalone-cinder; \
	make
.PHONY: openstack/standalone-cinder

test-openstack/standalone-cinder:
	cd openstack/standalone-cinder; \
	make test
.PHONY: test-openstack/standalone-cinder

clean-openstack/standalone-cinder:
	cd openstack/standalone-cinder; \
	make clean
.PHONY: clean-openstack/standalone-cinder

test-snapshot:
	cd snapshot; \
	make test
.PHONY: test-snapshot

push-cephfs-provisioner:
	cd ceph/cephfs; \
	make push
.PHONY: push-cephfs-provisioner

push-rbd-provisioner:
	cd ceph/rbd; \
	make push
.PHONY: push-rbd-provisioner

push-efs-provisioner:
	cd aws/efs; \
	make push
.PHONY: push-efs-provisioner

push-glusterblock-provisioner:
	cd gluster/block; \
	make push
.PHONY: push-glusterblock-provisioner

push-glusterfs-simple-provisioner:
	cd gluster/glusterfs; \
	make push
.PHONY: push-glusterfs-simple-provisioner

push-iscsi-controller:
	cd iscsi/targetd; \
	make push
.PHONY: push-iscsi-controller

push-local-volume-provisioner-bootstrap:
	cd local-volume/bootstrapper; \
	make push
.PHONY: push-local-volume-provisioner-bootstrap

push-local-volume-provisioner:
	cd local-volume/provisioner; \
	make push
.PHONY: push-local-volume-provisioner

push-nfs-client-provisioner: nfs-client
	cd nfs-client; \
	make push
.PHONY: push-nfs-client-provisioner

push-nfs-provisioner:
	cd nfs; \
	make push
.PHONY: push-nfs-provisioner

push-openebs-provisioner:
	cd openebs; \
	make push
.PHONY: push-openebs-provisioner

deploy-openebs-provisioner:
	cd openebs; \
	make deploy
