# 🎮 RedX Game Library

**モダンなSteamゲームライブラリとマネージャー**

![Version](https://img.shields.io/badge/バージョン-v2.1-red)
![Language](https://img.shields.io/badge/言語-Python-blue)
![Platform](https://img.shields.io/badge/プラットフォーム-Windows-lightgrey)
![License](https://img.shields.io/badge/ライセンス-CPL-green)

<div align="center">
  <img src="https://github.com/user-attachments/assets/642c0a5c-47d0-4beb-adb9-cbed85031666" alt="RedX Game Library" width="800">

  **エレガントな赤と黒のテーマを備えた、モダンで多言語対応のSteamゲームライブラリマネージャー**
</div>

## 📋 目次

- [機能](#-機能)
- [インストール](#-インストール)
- [使用方法](#-使用方法)
- [言語サポート](#-言語サポート)
- [システム要件](#-システム要件)
- [貢献](#-貢献)
- [ライセンス](#-ライセンス)

## ✨ 機能

### 🎨 モダンなインターフェース
- **赤黒テーマ**: エレガントでモダンな外観
- **レスポンシブデザイン**: 異なる画面サイズに適応
- **アニメーション要素**: スムーズな遷移とエフェクト

### 🌍 多言語サポート
- 🇹🇷 **トルコ語** (主要言語)
- 🇺🇸 **英語**
- 🇩🇪 **ドイツ語**
- 🇷🇺 **ロシア語**
- 🇯🇵 **日本語**

### 🎮 ゲーム管理
- **ゲーム検索**: 高速で効果的な検索システム
- **ジャンルフィルタリング**: ジャンル別にゲームをフィルタリング
- **インストール追跡**: インストール済みゲームの表示と管理
- **Steam統合**: Steam Storeページへの直接アクセス

### 🔧 高度な機能
- **自動更新**: GitHub経由での自動更新チェック
- **Steamパス検出**: 自動Steamフォルダ検出
- **DLCサポート**: ゲームDLCの管理
- **進行状況追跡**: ダウンロードとインストールの進行状況

## 🚀 インストール

1. [Releases](https://github.com/Scriptez1/RedXFreeSteamInstaller/releases/latest)から最新の`RedXGameLibrary.exe`をダウンロード
2. `RedXGameLibrary.exe`をダブルクリックして実行
3. インストール不要！

## 📖 使用方法

### 初回起動
1. アプリケーション起動時にSteamパスが自動検出されます
2. 検出されない場合は、手動でSteamフォルダを選択してください
3. 1ページに表示するゲーム数を設定してください（推奨：9）

### ゲーム検索とフィルタリング
- **検索ボックス**: ゲーム名で検索
- **ジャンルフィルター**: 右パネルからジャンルを選択してフィルタリング
- **フィルター適用**: 「フィルター」ボタンをクリックして選択を適用

### ゲーム管理
- **ゲーム追加**: ゲームカードの「追加」ボタンをクリック
- **ゲーム削除**: インストール済みゲームの「削除」ボタンを使用
- **Steamで表示**: ゲームのSteamページを開く

### 言語切り替え
- 右パネルの国旗アイコンをクリックして言語を変更
- 言語変更後、アプリケーションが自動的に再起動します

## 🌍 言語サポート

アプリケーションは以下の言語をサポートしています：

| 言語 | コード | ステータス |
|------|--------|-----------|
| トルコ語 | `tr` | ✅ 完全サポート |
| 英語 | `en` | ✅ 完全サポート |
| ドイツ語 | `de` | ✅ 完全サポート |
| ロシア語 | `ru` | ✅ 完全サポート |
| 日本語 | `ja` | ✅ 完全サポート |

## 💻 システム要件

### 最小要件
- **オペレーティングシステム**: Windows 10以上
- **RAM**: 4 GB
- **ストレージ**: 100 MB の空き容量
- **インターネット**: アクティブな接続が必要

### 推奨要件
- **オペレーティングシステム**: Windows 11
- **RAM**: 8 GB
- **ストレージ**: 500 MB の空き容量
- **インターネット**: 高速接続

## 📁 プロジェクト構造

```
RedXFreeSteamInstaller/
├── gui.py              # メインGUIアプリケーション
├── index.py            # ゲームダウンロードと処理モジュール
├── languages.py        # 多言語サポート
├── config.py           # 設定ファイル
├── changes.txt         # 変更ログ
└── resources/          # リソースファイル
    ├── icon.ico        # アプリケーションアイコン
    ├── games.json      # ゲームデータベース
    ├── censored.png    # 検閲画像
    ├── redx.dll        # Steamプラグイン
    └── flags/          # 国旗画像
        ├── TRflag.png
        ├── ENflag.png
        ├── DEflag.png
        ├── RUflag.png
        └── JPflag.png
```

## 🤝 貢献

1. リポジトリを**フォーク**
2. **機能ブランチ**を作成 (`git checkout -b feature/AmazingFeature`)
3. 変更を**コミット** (`git commit -m 'Add some AmazingFeature'`)
4. ブランチに**プッシュ** (`git push origin feature/AmazingFeature`)
5. **プルリクエスト**を開く

## 📝 ライセンス

このプロジェクトはMITライセンスの下でライセンスされています。詳細については`LICENSE`ファイルを参照してください。

## 🔗 リンク

- **GitHub**: [RedXFreeSteamInstaller](https://github.com/Scriptez1/RedXFreeSteamInstaller)
- **リリース**: [最新リリース](https://github.com/Scriptez1/RedXFreeSteamInstaller/releases)
- **Issues**: [問題を報告](https://github.com/Scriptez1/RedXFreeSteamInstaller/issues)

## ⚠️ 警告

このアプリケーションは教育目的です。Steamの利用規約に従って使用してください。

---


**RedX Game Library** - モダンなSteamゲームマネージャー 🎮
