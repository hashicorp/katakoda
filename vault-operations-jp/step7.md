サーバーの初期化をする際に暗号化キー、Unseal(開封)キー、そしてrootトークンの生成が行われましたが、このプロセスは一度しか実行されません。あるいはサーバーの設定が変更され別の新しいストレージに繋げた場合も初期化が必要となります。

基本的に初期化は一度だけ行うプロセスですが、マスターキーを再び生成する必要が出てくる事があるかもしれません。例えば…

- Unsealキーの保持者だった社員が辞めた場合
- セキュリティエンジニアが安全性を高める為にUnsealキーの数を増やしたい場合
- 組織内の規定で定期的にマスターキーを回転させなければいけない場合

更にはマスターキーによって暗号化されている暗号化キーを回転する必要が出てくるかもしれません。

![](./assets/rekey-and-rotate.png)

`rekeying`と`rotating`は２つの異なるオペレーションとなっていて、[Shamir's Secret Sharing Algorithm](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing)によってUnsealキーを再生成するプロセスを"**rekeying**"と呼び、新しい暗号化キーを生成するプロセスを"**rotating**"と呼びます。

<br>

## Rekeying Vault

まず最初にrekeyingオペレーションの初期化をします。この時点でUnsealキーの数とUnseal(開封)に必要なUnsealキーの数を指定し調整する事ができます。

以下のコマンドを実行してキー分割の数を`3`、そしてUnseal(開封)に必要なキーの数を`2`に設定します。

```
vault operator rekey -init -key-shares=3 -key-threshold=2 \
    -format=json | jq -r ".nonce" > nonce.txt
```{{execute T2}}

この際、nonceが生成され、rootキーの生成の時と同じく個々のUnsealキー保持者が以下のコマンドを実行する必要があります。

```
vault operator rekey -nonce=$(cat nonce.txt) \
    $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T2}}

アウトプットにはプログレスが表示されます(`1/3`)。

２つ目のUnsealキーを入力します。

```
vault operator rekey -nonce=$(cat nonce.txt) \
    $(grep 'Key 2:' key.txt | awk '{print $NF}')
```{{execute T2}}


最後に３つ目のUnsealキーを入力。

```
vault operator rekey -nonce=$(cat nonce.txt) \
    $(grep 'Key 3:' key.txt | awk '{print $NF}')
```{{execute T2}}

過半数のunsealキーが入力された事により、新しいunsealキーが生成されます。

```
Key 1: a4By/JU6xqMxXG95FtcShLldGS4GDZmcUcCD4Q83cl2b
Key 2: dWBDfbTicxDwCbmi7TQnKBdecdyfWWi+25Pj2xN+vlnb
Key 3: zZk7kYLu02E/UENLmCjBSzu76SQaqnVt9RtcYeTQYsf4

Operation nonce: cc9f9311-7945-3b91-9af4-96d94eba83ae

Vault rekeyed with 3 key shares an a key threshold of 2. Please securely
distributed the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 2 of these keys to unseal it
before it can start servicing requests.
```

<br>

## Rotating Encryption Key

Rekeyingと違って暗号化キーの回転はunsealキーを必要としません。

新しい暗号化キーの生成は以下のコマンドを実行してください。

```
vault operator rotate
```{{execute T2}}

暗号化キーは表示されることはなく、その代わりに暗号化キーのバージョンとインストール時間が表示されます。以後、データの暗号化には、この新しい暗号化キーが使われます。
