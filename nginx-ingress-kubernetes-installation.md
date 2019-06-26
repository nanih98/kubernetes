
## NGINX INGRESS CONTROLLER INSTALLATION ---- KUBERNETES CLUSTER


$ git clone https://github.com/nginxinc/kubernetes-ingress.git

Run: 

$ cd kubernetes-ingress
$ cd deployments

$ kubectl create -f common/ns-and-sa.yaml

$ kubectl create -f common/default-server-secret.yaml

$ kubectl create -f common/nginx-config.yaml

$ kubectl create -f rbac/rbac.yaml

$ kubectl create -f daemon-set/nginx-ingress.yaml
