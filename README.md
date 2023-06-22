# Defense Unicorns Big Bang Distro on AWS

Repository was used for a Live event and demonstration of deploying Defense Unicorns Big Bang Distro on June 22, 2023. You should look at [uds-package-dubbd](https://github.com/defenseunicorns/uds-package-dubbd) for the latest and greatest packages, documentation, etc...

[This](https://medium.com/defense-unicorns/defense-unicorns-big-bang-distribution-1276e6309718) post on Medium, also has a good overview and instructions.

## Quick Start
_I didn't convince you to look elsewhere... you sure..._

Repeating the demo is relatively easy :) - I recommend taking a look at `zarf-config.yaml` on the few variables exposed by Defense Unicorns Big Bang Distro.

0. `docker login ghcr.io -u {user} -p {token}` - credentials used to pull the dubbd oci artifact
1. `aws configure` - for your target environment
2. `cd infra && terraform init && terraform apply` - deploy resources for saving terraform state. (extra credit if you integrate into the zarf package in the infra folder)
3. `eksctl create cluster -f infra/config.yaml` - deploy the EKS cluster, (alternative use the Zarf package in [./infra/zarf.yaml](./infra/zarf.yaml))
4. `zarf init --components git-server`
5. `zarf package deploy oci://ghcr.io/defenseunicorns/packages/dubbd-aws:0.3.0-amd64 --oci-concurrency=15 --confirm`

### Notes

1. bigbang.dev DNS record points to localhost by defaut.
   1. get your AWS loadbalancer IP and add records to your `/etc/hosts` in order to reach web ui's like neuvector.bigbang.dev | grafana.bigbang.dev
2. Teardown
   1. `cd infra; eksctl delete cluster -f config.yaml --disable-nodegroup-eviction --force; cd -;`