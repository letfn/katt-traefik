traefik.yaml: clean/traefik.yaml
	kustomize build clean > traefik.yaml

clean/traefik.yaml:
	-helm repo add traefik https://helm.traefik.io/traefik
	helm repo update
	helm template traefik traefik/traefik --version 9.19.1 --namespace=traefik --values=values.yaml > $@

diff: traefik.yaml clean/traefik.yaml
	kustomize build . > diff.yaml
	diff traefik.yaml diff.yaml
	rm -f diff.yaml
