# disk breaker

Update `terraform.tfvars` with project you want to start instances in. You may start more instances to get error faster see `main.tf` line 30 and below

```
export CREDS_PATH=~/.config/gcloud/credentials.json
export GOOGLE_CREDENTIALS=$(cat ${CREDS_PATH})

terraform init
terraform apply
```

it usually takes less then 24 hours to broke, check dmesg.

To destroy resources
```
terraform destroy
```
