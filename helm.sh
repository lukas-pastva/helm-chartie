#!/bin/bash

helm package charts/chart
helm repo index --url https://github.com/lukas-pastva/helm-chartie --merge index.yaml .