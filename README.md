# Cally `setup-cally`

This repository contains the Github Action `setup-cally` that can be used give a pre-configured Cally + Terraform CDK provider environment for use with your Cally based IDP

## Inputs

|                     | Default                | Description |
| --                  | --                     | --          |
| `cally-version`     | `latest`               | Optionally specify a cally version  |
| `cally-repo`        | `CallyCo-io/Cally`     | Optionally specify a source repo for an inhouse pre-built tool cache  |
| `python-version`    | `3.12`                 | Optionally override the python version (Only current active python versions have a pre-built tool-cache)  |
| `providers`         |                        | Terraform providers to pre-build + cache  |
| `token`             | `${{ github.token }}`  | Override workflow token used  |

## Examples

### Hosted Tool

```yaml
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Cally
        uses: CallyCo-io/setup-cally@v0.1
```

### Providers

Providers can be specified as comma separated `source/provider@version`, an explicit version is strongly recommended. YAML multi-line is supported, and hashicorp is assumed if no source is provided.

#### Single Provider

```yaml
      - name: Setup Cally
        uses: CallyCo-io/setup-cally@v0.1
        with:
          providers: random@3.6.0
```

#### Multiple Providers

```yaml
      - name: Setup Cally
        uses: CallyCo-io/setup-cally@v0.1
        with:
          providers: random@3.6.0,cloudflare/cloudflare@4.34.0
```

#### Multi-line Providers

```yaml
      - name: Setup Cally
        uses: CallyCo-io/setup-cally@v0.1
        with:
          providers: |
            random@3.6.0,
            cloudflare/cloudflare@4.34.0,
            hashicorp/google@5.32.0
```
