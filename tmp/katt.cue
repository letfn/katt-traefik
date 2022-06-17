package boot

import (
	"github.com/defn/boot"
)

repo: boot.#Repo & {
	repo_name:     "katt-traefik"
	chart_repo:    "https://helm.traefik.io/traefik"
	chart_name:    "traefik"
	chart_version: "10.6.0"
	install:       "traefik"
	namespace:     "traefik"
	variants: {
		_commonAdditionalArguments: [
			"--providers.kubernetescrd.allowexternalnameservices=true",
			"--providers.kubernetescrd.allowCrossNamespace=false",
			"--log.level=DEBUG",
			"--accesslog=true",
			"--serverstransport.insecureskipverify=true",
			"--global.sendanonymoususage=false",
		]
		_commonConfig: {
			ports: traefik: port:             9200
			ingressRoute: dashboard: enabled: false
		}

		base: values: _commonConfig & {
			additionalArguments: _commonAdditionalArguments + [
						"--entrypoints.websecure.http.middlewares=traefik-traefik-forward-auth",
						"--certificatesresolvers.letsencrypt.acme.email=iam@defn.sh",
						"--certificatesresolvers.letsencrypt.acme.storage=/data/acme/acme.json",
						"--certificatesresolvers.letsencrypt.acme.caserver=https://acme-v02.api.letsencrypt.org/directory",
						"--certificatesResolvers.letsencrypt.acme.dnschallenge=true",
						"--certificatesResolvers.letsencrypt.acme.dnschallenge.provider=cloudflare",
						"--certificatesresolvers.letsencrypt.acme.dnschallenge.resolvers=108.162.193.160:53",
			]
			ports: web: redirectTo: "websecure"
			env: [{
				name: "CF_DNS_API_TOKEN"
				valueFrom: secretKeyRef: {
					name: "cloudflare"
					key:  "dns-token"
				}
			}]
		}
		relay: values: _commonConfig & {
			additionalArguments: _commonAdditionalArguments
			ports: websecure: expose: false
		}
	}
}
