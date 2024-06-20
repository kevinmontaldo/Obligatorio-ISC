
resource "kubectl_manifest" "storage_db" {
    yaml_body = <<YAML
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: storage_db
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  fsType: ext4
reclaimPolicy: Retain
mountOptions:
  - debug
YAML
}

resource "kubectl_manifest" "db_pvc" {
    yaml_body = <<YAML
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: db-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: storage_db
YAML
}

resource "kubectl_manifest" "db_svc" {
    yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: db_svc
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
        volumeMounts:
        - name: db-storage
          mountPath: /var/lib/mysql
      volumes:
      - name: db-storage
        persistentVolumeClaim:
          claimName: db-pvc
YAML
}
resource "kubectl_manifest" "web_svc" {
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

YAML
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
    define('DB_HOST', 'db_svc');
    define('DB_USER', '${var.db_user}');
    define('DB_PASSWORD', '${var.db_password}');
    define('DB_DATABASE', '${var.db_name}');
metadata:
  name: db-config
YAML
}