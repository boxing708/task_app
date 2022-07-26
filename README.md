# TaskApp

TaskAppはタスク管理アプリです。

# DEMO

▼ Demo はこちらです

https://task-app-708.herokuapp.com/

Email：708.gennadygolovkin@gmail.com  
Password：superstudio

# Features

### 現在の機能

- ログイン機能(メール認証機能付き)
- ログアウト機能
- タスク新規作成機能
- タスク編集機能
- タスクアサイン機能
- タスクがアサインされたユーザにメール&Slackでお知らせ機能
<img width="604" alt="スクリーンショット 2022-09-08 19 17 21" src="https://user-images.githubusercontent.com/107534005/189585672-e8ff9c9a-25dd-4490-ac5c-93ca3d7ac7cb.png">

- タスク検索機能
- タスクソート機能
- コメント機能
- ページネーション機能(タスク・コメント)
- 期限切れタスクと期限内タスクの区別

### ER図

<img width="841" alt="スクリーンショット 2022-09-01 14 39 53" src="https://user-images.githubusercontent.com/107534005/187840259-318fd2a0-58fa-4fe7-8aa6-82959debaedb.png">

# Requirement

### 環境

- macOS Monterey 12.5.1
- rails(5.2.3)
- ruby(2.7.6)
- Node(16.15.1)
- npm(8.11.0)
- yarn(1.22.19)

### ライブラリ

##### global

- gem 'dotenv-rails'
- gem 'rails_12factor', group: :production
- gem 'devise'
- gem 'bootstrap'
- gem 'jquery-rails'
- gem "kaminari"
- gem 'bootstrap4-kaminari-views'
- gem 'devise-i18n'
- gem "font-awesome-sass", "~> 6.1.2"
- gem 'ransack'

##### development, test

- gem 'mysql2', '>= 0.4.4', '< 0.6.0'
- gem 'rspec-rails'
- gem "factory_bot_rails"

##### development

- gem 'pry-rails'
- gem 'better_errors'
- gem 'binding_of_caller'
- gem 'letter_opener_web', '~> 2.0'
- gem "bullet"


##### test

- gem 'capybara', '>= 2.15'
- gem 'selenium-webdriver'

##### production

- gem 'pg'
- gem "aws-sdk-s3", require: false

# Usage(Local 環境)

1. TaskApp をダウンロードする

```shell
$ git clone https://github.com/boxing708/task_app.git
$ cd task_app
```

2. 必要なライブラリをインストールし、サーバを立てる


```shell
TaskApp $ bundle install
TaskApp $ rails db:create
TaskApp $ rails db:migrate
TaskApp $ rails s
```

# Note

今後やるべきこと

- テストを書く　<br>

# Author

- Naoya Shishikura
- 708.baseball.ster@gmail.com
