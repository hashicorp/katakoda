初期化の際に生成された**initial root token**(`key.txt`{{open}})を使ってログインします。

```
vault login $(grep 'Initial Root Token:' key.txt | awk '{print $NF}')
```{{execute T2}}

Audit devicesとはVaultによってプロセスされる全てのリクエストと返答の詳細を監査ログとして記録するコンポーネントです。APIを介して行われるVaultサーバーとクライアントのコミュニケーションを(エラーも含め)全て記録します。

以下のコマンドを実行して監査ログ有効化します。

```
vault audit enable file file_path=/var/log/vault-audit.log
```{{execute T2}}

監査ログは`/var/log/vault-audit.log`に記録されます。

> 現在、監査ログの回転はされないので、数多くあるログ管理のツールを利用する事をお勧めします。

監査ログはJSON形式で、APIのリクエストメッセージとレスポンスメッセージが記録されています。機密情報は暗号化されたハッシュ値として記録されます。

まずJSONファイルを読みやすくする為に`jq`ツールをインストールしましょう

```
apt-get install jq -y
```{{execute T2}}

では監査ログをみて見ましょう。

```
cat /var/log/vault-audit.log | jq
```{{execute T2}}

監査ログには全てのリクエストオブジェクト、それに対するレスポンスオブジェクト、そしてリクエストを発信するのに使われた認証トークンも記録されていますが認証トークンは**HMAC-SHA256**を使って暗号化されているのでハッシュ値が記録されています。

```
{
  "time": "2018-06-06T00:07:52.570688813Z",
  "type": "response",
  "auth": {
    "client_token": "hmac-sha256:7f1faa30ae941a21f3705e6796a46ad82a3f8066eb365eb5d35d9a0e1f178ecd",
    "accessor": "hmac-sha256:f0f449772db0c6128c2f940c44f581be34824545b00fec28d2269aa60fa15c37",
    "display_name": "root",
    "policies": [
      "root"
    ],
    ...
```
