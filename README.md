# BecaGIS Docs Deploy

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