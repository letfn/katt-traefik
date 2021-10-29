build: clean main.yaml ../relay.yaml

../relay.yaml: main.yaml
	kustomize build >$@

main.yaml: clean/main.yaml
	kustomize build clean >$@

clean/main.yaml: values.yaml
	-helm repo add traefik https://helm.traefik.io/traefik
	helm repo update
	helm template traefik traefik/traefik --version 10.6.0 --namespace=traefik --values=values.yaml --include-crds --kube-version 1.21 >$@

.PHONY: clean
clean:
	rm -f clean/main.yaml
