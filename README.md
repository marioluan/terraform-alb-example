# terraform-alb-example
Dummy ALB implementation using Terraform, Docker, Nginx and Python/FastAPI.

**Pre-requisites**
- [Docker](https://docs.docker.com/get-docker/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)

## Usage
### Deploy the clusters
> Take a look at `terraform/main.tf` to customize the cluster.
```bash
# build the web server
cd web-server
docker build . -t web-server
cd ..

cd terraform
# initialize the module
terraform init

# deploy
terraform apply
cd ..
```

### Check cluster health
```bash
./bin/cluster-manager status "cluster_a"
./bin/cluster-manager status "cluster_b"
```

### Stop the cluster
```bash
./bin/cluster-manager stop "cluster_a"
./bin/cluster-manager stop "cluster_b"
```

### Start the cluster
```bash
./bin/cluster-manager start "cluster_a"
./bin/cluster-manager start "cluster_b"
```

### Destroy the cluster
```bash
cd terraform
terraform destroy
cd ..
```

## Architecture
### Deployable units
The cluster consists of 1 ALB and N web servers. The ALB is implemented as a nginx container and the web server is implemented as a Python/FastAPI. There are two clusters defined in the root module: `cluster_a` and `cluster_b` - each listening traffic on its own port (80 and 8080, respectively).

### Package structure
* /bin: contains a script to manage the cluster (start/stop/status).
* /terraform: contains the automation of the infra.
* /web-server: contains the web server implementation.