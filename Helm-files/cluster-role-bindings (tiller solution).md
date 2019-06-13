# Clusterrolebinding solution for helm tiller

## Problem:

User "system:serviceaccount:kube-system:default" cannot get resource "namespaces" in API group "" in the namespace "default"

## Solution:

$ kubectl --namespace kube-system create serviceaccount tiller
$ kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
$ helm init --service-account tiller --upgrade
