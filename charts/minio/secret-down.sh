#!/bin/bash

kubectl=/snap/bin/kubectl

$kubectl -n minio delete secret minio-credentials
