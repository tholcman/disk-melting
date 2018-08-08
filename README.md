# disk breaker

Update `west1.tfvars` & `west2.tfvars`
```
export CREDS_PATH=~/.config/gcloud/credentials.json
export GOOGLE_CREDENTIALS=$(cat ${CREDS_PATH})

terraform init
terraform workspace new west1
terraform apply -var-file west1.tfvars

terraform workspace new west2
terraform apply -var-file west2.tfvars
```

in less then 24 hours it should be broken, check dmesg.

To destroy resources

```
terraform workspace select west2
terraform destroy

terraform workspace select west1
terraform destroy
```
