<<<<<<< HEAD
# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

株式会社ゆめみさんのIOSコードチェック課題の概要をまとめる。
主にIssuesの初級にチャレンジしてリファクタリングしたいった。


### 環境

- IDE：Xcode 13.21
- Swift：Swift 5.52
- 開発ターゲット：iOS 15.0

### 課題

以下の４つについてソースコードを修正した。
1.可読性の向上
2.安全性の向上
3.バグを修正
4.FatVCの回避

ただし、今回自分の実力が及んでいなかったため
うまく実装しきれていないところもある。
その部分は苦労した部分、つまづいた部分などを記載しておくこととする。


・今回は一人での作業だが、実務では共同開発が予想される
・他人から見て何の作業をしていて何を変更したのかわかりやすい
という観点から今回はブランチをIssuesごとに分けて作業した。

1:Main
1-1:develop
1-1-1:feature/bug(バグを修正)
1-1-2:feature/safety(安全性の向上)
1-1-3:feature/readability(可読性の向上)
1-1-4:feature/FatVC(Fat VCの回避)
1-1-5:README.md(README.mdの作成)

このようなブランチの分け方をした。
（1-1は1のMainブランチの派生を表し、1-1-1は1-1のdevelopブランチの派生を表す。）

 
 
### バグを修正
1.レイアウト修正に関しては、検索結果画面の詳細が画面上部にずれているという点を直した。  
オートレイアウトの”Add Missing Constraints”を使用して調整を行なった。

2.メモリリークに関しては循環参照をしている箇所を２箇所ほど"weak   self"を加えて循環参照を防ぐことでメモリリークを防いだ。

3.パースエラーの箇所に関しては、特に自分は見つからなかったため特に何もしていない。

### 安全性の向上
1.こちらについては、if letを用いることで安全にアンラップできるようにした。

2.さらに不要なIUOを排除した。

### 可読性の向上
1.命名規則の変更  
1.1:クラス名をその画面の役割の名前に変更した。  
ViewController　→ SearchViewContlroller   
ViewController2　→ ResultViewContlroller  

2.2:省略されている変数を省略無しにした。  
例）idx　→ index

3.3:改行、インデント  
{　の後は１行あける  
}　の前の行は開けない  
このように修正した。  

### Fat VCの回避  
こちらに関して今回一番苦労した。  
＜やったこと＞  
MVCモデルの適用をして、Modelに変数を保持した。  
  
＜やりたかったこと＞  
MVVMモデルの採用  
Model：データ保持  
ViewModel：プロトコルを用いて、基本的な処理はここで  
View：ViewModelのプロトコルに準拠させて、基本的にはViewのみを行う。  
  
採用理由：SwiftUIでの共同開発をしていて、  
そこで使っているモデルがMVVCモデルだったので自分が一番理解していた。  
（過去にJavaでMVCモデルをやってみたが、扱いづらかった。）  
  
＜苦労した点＞  
SearchBarの処理やTableViewの処理を全てViewControllerでやっているため  
FatVCが起きていると考えたためそこを分離させたかった。  
SearchBarがSearchViewControllerに紐づいていたのを  
うまくView Modelに紐付けを変更できなかった。  


## 参考記事

[良いコードの書き方](https://qiita.com/alt_yamamoto/items/25eda376e6b947208996)  
[Swiftのメモリリークについてまとめてみた - Qiita](https://qiita.com/ryu1sazae/items/201275f9ac3af1ec9e64)  
[【Optional型】アンラップの仕方や非Optional型との違い](https://tech-maga.com/swift-optional)  

