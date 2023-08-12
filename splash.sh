#!/bin/zsh

flutter clean
flutter pub get
flutter pub run flutter_native_splash:remove --path=splash.yaml
flutter pub run flutter_native_splash:create --path=splash.yaml