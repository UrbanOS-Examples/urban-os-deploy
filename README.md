## Force deployment life hack

When doing a `terraform apply`, if no changes have been made to the helm charts, it may be unaware of dependency changes and will not redeploy.

To ensure dependencies are updated every time, use the following command:

(Fish)

```
terraform apply --var-file=variables/sandbox.tfvars -var="force_deployment="(random)
```

(Zsh, and probably also Bash)

```
terraform apply --var-file=variables/sandbox.tfvars -var="force_deployment="$RANDOM
```

This sets a dummy variable, `force_deployment`, to a new random value each time it is run.
