#!/bin/bash

#keytool -genkey -v -keystore ./android/app/debug.keystore -alias debugKey -keyalg RSA -keysize 2048 -validity 10000
./gradlew signingReport