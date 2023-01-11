#!/bin/bash

helm package charts/chart
helm repo index --url https://lukas-pastva.github.io/helm-chartie --merge index.yaml .