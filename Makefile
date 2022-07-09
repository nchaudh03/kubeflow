install_k3d:
	curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=v5.0.0 bash


create_cluster:
	k3d cluster create -p "8081:80@loadbalancer" --k3s-arg "--disable=traefik@server:0" 
	kubectl config use-context k3d-k3s-default
	kubectl cluster-info
	kubectl version

delete_cluster:
	k3d cluster delete

install_kubeflow:
	while ! kustomize build example | kubectl apply -f -; do echo "Retrying to apply resources"; sleep 10; done

apply_fixes:
	kubectl apply -f ~/Documents/Kubeflow/importantlocal/pipelineaccess.yaml
	kubectl apply -f ~/Documents/Kubeflow/importantlocal/kserve-secret.yaml
	kubectl apply -f ~/Documents/Kubeflow/importantlocal/kserve-securityaccount.yaml
