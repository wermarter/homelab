#!/bin/bash

kubectl -n rook-ceph patch cephcluster rook-ceph --type merge -p '{"spec":{"cleanupPolicy":{"confirmation":"yes-really-destroy-data"}}}'

helm uninstall -n rook-ceph rook-ceph-cluster
