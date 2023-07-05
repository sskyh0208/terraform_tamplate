# Enviroments

構成が環境毎に変わらないことを想定した作りになっています。
<br/>
<br/>
## _common
---

環境毎に変わらないものをここに記述します。

|ファイル|説明|
|---|---|
|main.tf|構築用メインファイル|
|provider.tf|プロバイダー情報を記述する|
|variables.tf|プロジェクト固有の値を記述する|

<br/>
<br/>

## dev, stg, prod
---

環境毎に変わるものをここに記述します。  
main.tf、provider.tf、variables.tfは```_common```ファイルへのシンボリックリンクです。

|ファイル|説明|
|---|---|
|backend.tf|データファイル保存先を記述する|
|locals.tf|環境固有の値を記述する|