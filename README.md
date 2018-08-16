# Katakoda

Interactive hands-on labs for [Katacoda](https://www.katacoda.com/hashicorp/)

## Authoring

See the `consul-connect` project for a recently refactored approach to building and running interactive tutorials.

### Directory Layout

    assets/
           images/

### Workflow Commands

Shared `make` commands have been implemented to enable the authoring process.

* `make images`: Compresses all images under the `assets/images` directory for the web
* `make deploy`: Copies assets to our public bucket.
