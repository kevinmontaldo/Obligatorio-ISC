resource "kubectl_manifest" "db" {
    yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: db
  name: db
spec:
  replicas: 1
  selector:
    matchLabels:
      app: db
  strategy: {}
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
      - name: db
        image: "${local.aws_ecr_url}/db"
YAML
}
resource "kubectl_manifest" "db_svc" {
    yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: db
spec:
  type: ClusterIP
  selector:
    app: db
  ports:
  - name: mysql
    port: 3306
    targetPort: 3306
YAML
}

resource "kubectl_manifest" "web" {
    yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: web
  name: web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web
  strategy: {}
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: web  
        image: "${local.aws_ecr_url}/web"
YAML
}

resource "kubectl_manifest" "web_svc" {
    yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  type: ClusterIP
  selector:
    app: web
  ports:
  - name: apache
    port: 80
    targetPort: 80
YAML
}