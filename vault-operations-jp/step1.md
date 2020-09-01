まずはVaultの[バイナリファイル](https://www.vaultproject.io/downloads.html)をダウンロードします。

> 以下のコマンドをターミナル内にタイプして実行するか、あるいはリターンの記号 (`⮐`) をクリックすると自動的にコマンドがターミナルにコピーされ
Vaultのバイナリファイルのダウンロードが実行されます。

```
export VAULT=1.5.3
wget https://releases.hashicorp.com/vault/${VAULT}/vault_${VAULT}_linux_amd64.zip
```{{execute}}


ダウンロード完了後、ZIP形式で圧縮されたファイルを開きVaultのバイナリファイルを取り出した後、必要となくなったZIPファイルは削除してしまいます。

```
unzip vault_${VAULT}_linux_amd64.zip && rm vault_${VAULT}_linux_amd64.zip
```{{execute}}

解凍されたバイナリファイルを確かめてみましょう。

```
ls -al | grep vault
```{{execute}}

Linux環境でVaultコマンドを実行しやすくする為、`vault`バイナリファイルを`/usr/bin`に移行します。

```
install -c -m 0755 vault /usr/bin
```{{execute}}

これでインストールは完了です！

では以下のコマンドを実行してインストールされたVaultのバージョンを確かめてみましょう。

```
vault version
```{{execute}}
