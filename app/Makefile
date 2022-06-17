main.yaml: values.yaml
	helm template traefik -n traefik katt-traefik/traefik -f values.yaml --version 10.21.1 > $@

values.yaml:
	cue export | jq -r '.app.variants.base.values' | yq -y > $@
