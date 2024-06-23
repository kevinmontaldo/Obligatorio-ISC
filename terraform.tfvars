# AWS Network

profile          = "default"
region           = "us-east-1"     			# Region de la VPC
vpc_cidr         = "172.16.0.0/16" 			# Direccion de red de la VPC
subnet_A         = "172.16.1.0/24" 			# Direccion de red de la subred A
subnet_B         = "172.16.2.0/24" 			# Direccion de red de la subred B
az_1             = "us-east-1a"    			# Region de la Avaliability Zone 1
az_2             = "us-east-1b"				# Region de la Avaliability Zone 2

# RDS 

db_name          = "db_obligatorio"			# Nombre de la base de datos
db_user          = "user"				# Usuario de la base de datos
db_password      = "user1234567"			# Contraseña del usuario
db_root_password = "root1234567"			# Contraseña del usuario Root

# S3

current_transition_days_to_standard = 60		# Cantidad de dias para pasar archivos a S3 Standard-IA
current_transition_days_to_glacier = 180		# Cantidad de dias para pasar archivos a S3 Glacier
noncurrent_transition_days_to_standard = 30		# Cantidad de dias para pasar archivos con versiones anteriores a S3 Standard-IA
noncurrent_transition_days_to_glacier = 90		# Cantidad de dias para pasar archivos con versiones anteriores a S3 Glacier
current_expiration_days = 3650				# Cantidad de dias para eliminar archivos
noncurrent_expiration_days = 365			# Cantidad de dias para eliminar archivos con versiones anteriores

