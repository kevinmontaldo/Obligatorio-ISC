resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name cluster_obligatorio"
  }
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
    server_side_apply = true
    depends_on = [null_resource.kubectl] 
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
    define('DB_HOST', '${var.db_endpoint}');
    define('DB_USER', '${var.db_user}');
    define('DB_PASSWORD', '${var.db_password}');
    define('DB_DATABASE', '${var.db_name}');
metadata:
  name: db-config
YAML
    server_side_apply = true
    depends_on = [kubectl_manifest.web-svc]
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
  replicas: 4
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
    server_side_apply = true
    depends_on = [kubectl_manifest.db-config]
}

resource "kubectl_manifest" "job-mysql-init" {
  yaml_body = <<YAML
apiVersion: batch/v1
kind: Job
metadata:
  name: job-mysql-init
spec:
  template:
    spec:
      containers:
      - name: job-container
        image: "${local.aws_ecr_url}/web"
        command: ["sh", "-c", "mysql -h '${replace(var.db_endpoint, ":3306", "")}' -u '${var.db_user}' -p'${var.db_password}' '${var.db_name}' < dump.sql"]
      restartPolicy: Never
YAML
    server_side_apply = true
    depends_on = [kubectl_manifest.db-config]
}
