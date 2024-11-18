#!/bin/bash

kubectl=/snap/bin/kubectl

$kubectl -n prometheus-stack delete secret grafana-credentials
