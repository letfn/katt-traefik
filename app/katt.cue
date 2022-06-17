package katt

app: {
	repo_name:     "katt-traefik"
	chart_repo:    "https://helm.traefik.io/traefik"
	chart_name:    "traefik"
	chart_version: "10.21.1"
	install:       "traefik"
	namespace:     "traefik"
	variants: {
		base: values: {
			ports: traefik: port:             9200
			ingressRoute: dashboard: enabled: false
			additionalArguments: [
				"--providers.kubernetescrd.allowexternalnameservices=true",
				"--providers.kubernetescrd.allowCrossNamespace=false",
				"--log.level=DEBUG",
				"--accesslog=true",
				"--serverstransport.insecureskipverify=true",
				"--global.sendanonymoususage=false",
			]
			ports: web: redirectTo: "websecure"
		}
	}
}
