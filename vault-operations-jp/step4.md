Vaultのインストール後に初めてサーバーを起動する時、まずサーバーの初期化を行う事が必要となります。サーバーの初期化をすることにより暗号化キー、Unseal(開封)キー、そしてrootトークンの生成が行われます。

初期化には`vault operator init`コマンドを使います。
<br>

**Terminal 2**　にて以下のコマンドを実行してみましょう。

```
vault operator init > key.txt
```{{execute T2}}

<br>

## VaultサーバーのUnseal(開封)

Vaultサーバーが起動されると、サーバーはSeal(封印)された状態にあり、設定されたストレージに繋いでデータを取り出す事ができたとしても解読する事ができない、つまり操作が不可能な状態にあります。

Vaultにて格納される機密情報は、まず暗号化されてからストレージに送られるのですが、その暗号化する際に使われる暗号化キー自体が更にマスターキーによって暗号化されています。そのマスターキーはどこにも保存されないので、不正なアクセスがあったとしてもデータを複合する事が不可能に設計されています。

ではこのマスターキーはどうやって構成されるかと言うと、[Shamir's Secret Sharing Algorithm](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing)と言う数式を使って複数(デフォルトは５つ)に分割され、それをUnsealキー、あるいはSharedキーと呼びます。

![Shamir's Secret Sharing](./assets/vault-autounseal.pngs)

この初期化プロセスの際に分割されたUnsealキー(`key.txt`{{open}})は、それぞれ別の個人が安全に管理し、サーバーをUnseal(開封)する際にはその大多数が必要となります。例えば、５つのUnsealキーがある場合、過半数である３つのUnsealキーが入力されて初めてマスターキーが複合されます。このプロセスをUnseal(開封)と呼びます。つまりUnsealキー保持者５人のうち３人がUnseal(開封)プロセスに携わらないと完了しない為、誰か１人が全ての鍵を握るという事はありません。

マスターキーが複合されることによって初めて暗号化キーの解読ができ、Vaultの操作が可能となります。

> Unsealキーの数はサーバーの初期化の際に`-key-shares`と`-key-threshold`を使って調整する事ができます。

<br>

以下のコマンドを`vault operator unseal`実行して、１つ目のunsealキーを入力します。

```
vault operator unseal \
    $(grep 'Key 1:' key.txt | awk '{print $NF}')
```{{execute T2}}

アウトプットに`1/3`とUnseal(開封)プロセスのプログレスが表示されているのを注意して見てみましょう。

２つ目のunsealキーを入力します。

```
vault operator unseal \
    $(grep 'Key 2:' key.txt | awk '{print $NF}')
```{{execute T2}}


最後に３つ目のunsealキーを入力します。

```
vault operator unseal \
    $(grep 'Key 3:' key.txt | awk '{print $NF}')
```{{execute T2}}

これでVaultサーバーのUnseal(開封)が完了し操作が可能になりました。
