Vaultサーバーの設定は[HCL](https://github.com/hashicorp/hcl)かJSON形式のファイルで行います。

以下の設定を`config.hcl`{{open}}ファイルに書き込みましょう。

<pre class="file" data-filename="config.hcl" data-target="replace">
# Use the file system as storage backend
storage "file" {
  path = "/data/vault"
}

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}

ui = true
</pre>

上にある`storage`と`listener`は必須エントリーです。

この例では、データを保存する`storage`に`file`を使っていて、データは`/data/vault`に保存されます。本格的にVaultを導入する場合、[Consul](https://www.vaultproject.io/docs/configuration/storage/consul.html)をデータストレージに使うのが理想的ですが、それぞれの用途に合わせ、今回のようにファイルシステムを使う事もあればDynamoDBやCassandraを使う事も可能です。詳しくは[Vault Configuration](https://www.vaultproject.io/docs/configuration/index.html)を参照ください。

`listener`は、Vaultサーバーがクライアントからのリクエストを受ける為のリスナーで、現時点ではTCPプロトコールのみ対応しています。

<br>

## サーバーの起動

では`config.hcl`{{open}}ファイルの設定にしたがって、サーバーを起動してみましょう。

```
vault server -config=config.hcl
```{{execute T1}}

アウトプットを見ると設定通りに起動された事が確認できます。

```
==> Vault server configuration:

                     Cgo: disabled
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration:"1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: (not set)
                   Mlock: supported: true, enabled: true
                 Storage: file
                 Version: Vault v1.5.3
             Version Sha: c19cef14891751a23eaa9b41fd456d1f99e7e856
```

次のステップではサーバーの初期化をして行きます。
