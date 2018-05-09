# Fabric-Carthage

Answers, Crashlytics, Fabricのビルド済みFrameworkをCarthage対応するためのRepositoryです。

https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#binary-project-specification


## Carthageでの利用

Cartfileに下記のように記述してください

```
binary "https://raw.githubusercontent.com/ykyouhei/Fabric-Carthage/master/Crashlytics.json"
binary "https://raw.githubusercontent.com/ykyouhei/Fabric-Carthage/master/Answers.json"
binary "https://raw.githubusercontent.com/ykyouhei/Fabric-Carthage/master/Fabric.json"
```


## jsonの更新方法

```
$ bundle install --path vendor/bundle
$ bundle exec ruby scripts/gen_carthage_json.rb
```
