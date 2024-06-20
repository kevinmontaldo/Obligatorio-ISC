resource "kubectl_manifest" "db-svc" {
    yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: db-svc
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
        ports:
        - containerPort: 3306
YAML

    depends_on = [
        kubectl_manifest.db-svc
    ]
}

resource "kubectl_manifest" "db-config" {
    yaml_body = <<YAML
apiVersion: v1
kind: ConfigMap
data:
  config.php: |
    <?php
    ini_set('display_errors',1);
    error_reporting(-1);
    define('DB_HOST', 'db-svc');
    define('DB_USER', '${var.db_user}');
    define('DB_PASSWORD', '${var.db_password}');
    define('DB_DATABASE', '${var.db_name}');
metadata:
  name: db-config
YAML
}

resource "kubectl_manifest" "web-svc" {
    yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  type: LoadBalancer
  selector:
    app: web
  ports:
  - name: http
    port: 80
    targetPort: 80
YAML

    depends_on = [kubectl_manifest.db]
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
        ports:
        - containerPort: 80
        livenessProbe:
          initialDelaySeconds: 20
          periodSeconds: 15
          httpGet:
            path: /
            port: 80
        volumeMounts:
        - name: config-volume
          mountPath: /var/www/html/config.php
          subPath: config.php
      volumes:
      - name: config-volume
        configMap:
          name: db-config
YAML
    depends_on = [kubectl_manifest.web-svc, kubectl_manifest.db-config]
}

