初期化の際に生成されたrootトークンは、新しいサーバーを設定するのに必要なオペレーションを実行するのに使い、必要なポリシーを作成後は、rootトークンではなく個々の認証トークンを使ってVaultに繋ぐ事が優良な技法とされています。

その為、後にrootトークンが必要な事態が起きた時には`generate-root`コマンドを使い新しいrootトークンを生成する事ができます。

ヘルプメッセージを表示するには`help`あるいは`-h`を使ってみましょう。

```
vault operator generate-root -h
```{{execute T2}}

`clear`{{execute T2}}


始めに以下のコマンドを実行してrootトークン生成のオペレーションの初期化します。

```
vault operator generate-root -init > init-output.txt
```{{execute T2}}

> 上のコマンドによって生じた**Nonce**(`init-output.txt`{{open}})は、Unsealキーの保持者に知らせる必要があります。

rootトークンの生成には過半数のUnsealキーが必要で、個々のUnsealキー保持者がそれぞれ以下のコマンドを実行します。

```
vault operator generate-root \
    -nonce=$(grep 'Nonce' init-output.txt | awk '{print $NF}') \
    $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T2}}

下のアウトプット例は必要な３つのUnsealキーのうち１つが入力された事を示してます。

```
Nonce       f5368918-60c0-5122-77b5-38c5aca3375d
Started     true
Progress    1/3
Complete    false
```

２つ目のUnsealキーを入力します。

```
vault operator generate-root \
    -nonce=$(grep 'Nonce' init-output.txt | awk '{print $NF}') \
    $(grep 'Key 2:' key.txt | awk '{print $NF}')
```{{execute T2}}

最後に３つ目のUnsealキーを入力すると、暗号化された新しいrootトークン(`encoded_root.txt`{{open}})が生成されます。

```
vault operator generate-root -format=json \
    -nonce=$(grep 'Nonce' init-output.txt | awk '{print $NF}') \
    $(grep 'Key 3:' key.txt | awk '{print $NF}') \
    | jq -r ".encoded_root_token" > encoded_root.txt
```{{execute T2}}

以下のコマンドを実行して暗号化されたrootトークンを解読します。（注：解読の際にはOTPが再び必要）

```
vault operator generate-root -decode=$(cat encoded_root.txt) \
     -otp=$(grep 'OTP' init-output.txt | awk '{print $NF}') > root_token.txt
```{{execute T2}}

生成されたrootトークン(`root_token.txt`{{open}})を使いログインして確認してみましょう。

```
vault login $(cat root_token.txt)
```{{execute T2}}

トークンのポリシーが**root**である事を確認できたら完了です。


`clear`{{execute T2}}
