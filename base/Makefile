build: clean traefik.yaml

traefik.yaml: clean/traefik.yaml
	kustomize build clean > traefik.yaml

clean/traefik.yaml: values.yaml
	-helm repo add traefik https://helm.traefik.io/traefik
	helm repo update
	helm template traefik traefik/traefik --version 10.3.2 --namespace=traefik --values=values.yaml --kube-version 1.21> $@

diff: traefik.yaml clean/traefik.yaml
	kustomize build . > diff.yaml
	diff traefik.yaml diff.yaml
	rm -f diff.yaml

.PHONY: clean
clean:
	rm -f clean/traefik.yaml
