# PCF Tile upgrade Pipelines

This is a collection of [Concourse](https://concourse.ci) pipelines for
installing and upgrading [Pivotal Cloud Foundry](https://pivotal.io/platform).

## Usage

You'll need to [install a Concourse server](https://concourse.ci/installing.html)
and get the [Fly CLI](https://concourse.ci/fly-cli.html)
to interact with that server.

Depending on where you've installed Concourse, you may need to set up
[additional firewall rules](FIREWALL.md "Firewall") to allow Concourse to reach
third-party sources of pipeline dependencies.

## About the Tile upgrade

This pipeline is used to upgrade the Tiles installed in Ops Manager, with the exception of Ops Manager and the ERT tile which have thier
own upgrade pipelines.

NOTE: Each tile will have its own pipeline.

Each pipeline has an associated `params.yml` file next to it that you'll need to fill out with the appropriate values for that pipeline.

After filling out your params.yml, set the pipeline:

```
fly -t yourtarget login --concourse-url https://yourtarget.example.com
fly -t yourtarget set-pipeline \
  --pipeline upgrade-mysql \
  --config upgrade-tile/pipeline.yml \
  --load-vars-from upgrade-tile/params.yml
```
