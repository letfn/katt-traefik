build: clean traefik.yaml

traefik.yaml: clean/traefik.yaml
	kustomize build clean > traefik.yaml

clean/traefik.yaml: values.yaml
	-helm repo add traefik https://helm.traefik.io/traefik
	helm repo update
	helm template traefik traefik/traefik --version 10.3.5 --namespace=traefik --values=values.yaml --include-crds --kube-version 1.21 >$@

.PHONY: clean
clean:
	rm -f clean/traefik.yaml
