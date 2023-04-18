# BecaGIS Docs Deploy

- https://github.com/ncarlier/webhookd
- https://github.com/adnanh/webhook

```shell
webhook -hooks /home/ubuntu/VNTT/PROJECT/INTERNAL/BecaGIS_Docs_Deploy/hooks.json -verbose --port 9090 -hotreload -template
```


```json
[
  {
    "id": "becagis-docs-webhook",
    "execute-command": "/home/ubuntu/VNTT/PROJECT/INTERNAL/BecaGIS_Docs_Deploy/deploy.sh",
    "command-working-directory": "/home/ubuntu/VNTT/PROJECT/INTERNAL/BecaGIS_Docs_Deploy",
    "response-message": "Executing deploy script...",
    "trigger-rule": {
      "and": [
        {
          "match": {
            "type": "payload-hash-sha1",
            "secret": "YmVjYWdpcy1kb2NzCg==",
            "secret": "{{ getenv "BECAGIS_DOCS_SECRET" | js }}",
            "parameter": {
              "source": "header",
              "name": "X-Hub-Signature"
            }
          }
        },
        {
          "match": {
            "type": "value",
            "value": "refs/heads/deploy",
            "parameter": {
              "source": "payload",
              "name": "ref"
            }
          }
        }
      ]
    }
  }
]
```