podman run -d --name opensearch-node -p 9200:9200 -e "discovery.type=single-node" -e "plugins.security.disabled=true" -e "OPENSEARCH_INITIAL_ADMIN_PASSWORD=Prugio!03" 
podman run -p 9200:9200 -p 9600:9600 -e "discovery.type=single-node" -e "OPENSEARCH_INITIAL_ADMIN_PASSWORD=Prugio!03" opensearchproject/opensearch:1.3.0


docker network create opensearch-net

docker run -d --name opensearch-node1 --net opensearch-net -p 9200:9200 -p 9600:9600 \
  -e "discovery.type=single-node" \
  -e "OPENSEARCH_JAVA_OPTS=-Xms512m -Xmx512m" \
  opensearchproject/opensearch:latest

docker run -d --name opensearch-dashboards --net opensearch-net -p 5601:5601 \
  -e "OPENSEARCH_HOSTS=[\"http://opensearch-node:9200\"]" \
  opensearchproject/opensearch-dashboards:latest
  -v osdvolume: /usr/share/opensearch-dashboards
  OPENSEARCH_INITIAL_ADMIN_PASSWORD Prugio!03
  opensearch.hosts http://opensearch-node:9200

openseach.username admin
openseach.password Prugio!03

  podman network create opensearch-net

  https://timulyslog.tistory.com/627

  plugins.security.disabled=true


opensearch.ssl.verificationMode: none
opensearch.username: admin
opensearch.password: admin
opensearch.requestHeadersWhitelist: [authorization, securitytenant]

opensearch_security.multitenancy.enabled: false
opensearch_security.cookie.secure: false

sudo ./bin/opensearch-dashboards-plugin remove securityDashboards --allow-root

curl -v  -u admin:Prugio!03 "http://localhost:9200/_plugins/_security/api/account"
curl -v  admin:Prugio!03 "http://localhost:9200/_plugins/_security/api/account"

podman build --tag=opensearch-dashboards-no-security .

podman save -o opensearch-dashboards.tar localhost/opensearch-dashboards-no-security:latest
