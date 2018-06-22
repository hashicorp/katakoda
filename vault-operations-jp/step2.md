開発モードでVaultサーバーを起動すると、サーバーは自動的にUnseal(開封)され、rootトークンを使いログインする事で操作開始可能な状態になります。

以下のコマンドを実行し、サーバーを開発モードで起動しましょう。

```
vault server -dev -dev-root-token-id="root"
```{{execute}}

> 開発モードはすでにサーバー設定がされており、簡単にVaultをローカルPC上に起動することによって、様々なVaultの機能を試す事ができます。

ターミナルには以下のようなメッセージが表示されているのをみて見ましょう。

```
You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: zA1ujDttNWW9REd5I+VHCcYnmYiZHmBDs2QxZCVDgZc=
Root Token: root
```

このプロセスはフォアグラウンドで起動する為、コンソールが専有されます。以降の操作は別のターミナルをあげて実行して行きます。

**Terminal**の隣の**+**サインをクリックし、**Open New Terminal**を選び新しいターミナルを開きましょう。

<img src="https://s3-us-west-1.amazonaws.com/education-yh/ops-another-terminal.png" alt="New Terminal"/>


まずは開いた**Terminal 2**から`VAULT_ADDR`の環境変数を指定します:

```
export VAULT_ADDR='http://127.0.0.1:8200'
```{{execute T2}}

rootトークンを使ってログインします。

```
vault login root
```{{execute T2}}

これで準備は整いました。

では実際にデータを書き込んでみましょう。

```
vault kv put secret/customer/james name="James Bond" organization="MI6"
```{{execute T2}}

問題なく上のコマンドを実行する事ができました。

<br>

開発モードでサーバーが起動してる**Terminal**に戻り、**CTRL+C**でサーバーを停止してください。

<img src="https://s3-us-west-1.amazonaws.com/education-yh/ops-stop-server.png" alt="Stop Vault"/>

次のステップでは開発モードを使うのではなく、実際にサーバーの設定をして行きます。
