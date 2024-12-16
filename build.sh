#!/bin/bash

# production or dev
STAGE="production"
ENV="--dart-define ENV=$STAGE"

stage_pick() {
    echo "Choose the build env.:"
    select method in dev production; do
        case $method in
        "dev")
            STAGE="dev"
            sh setenv.sh -e dev
            ENV="--dart-define ENV=$STAGE"
            break
            ;;
        "production")
            STAGE="production"
            sh setenv.sh -e production
            ENV="--dart-define ENV=$STAGE"
            break
            ;;
        *)
            echo "Invalid selection. Please choose again."
            ;;
        esac
    done
}

build_mode() {
    if [ "$STAGE" == "dev" ]; then echo "Building Dev ..."; else echo "Building Production ..."; fi
    echo "Choose the build mode:"
    select method in buildAabOnly release build clean update; do
        case $method in
        "buildAabOnly")
            flutter clean && flutter pub get && flutter build appbundle $ENV
            break
            ;;
        "release")
            flutter clean && flutter pub get && cd ios && pod install && pod update && cd .. && flutter build ios $ENV && flutter build appbundle $ENV
            break
            ;;
        "build")
            flutter clean && flutter pub get && cd ios && pod install && pod update && cd .. && flutter build ios $ENV && flutter build apk
            break
            ;;
        "clean")
            flutter clean && rm -rf ~/Library/Developer/Xcode/DerivedData/ && rm -rf ios/Pods && rm -f pubspec.lock
            break
            ;;
        "update")
            flutter clean && rm -rf ~/Library/Developer/Xcode/DerivedData/ && rm -rf ios/Pods && rm -f pubspec.lock && cd ios && rm -f Podfile.lock && cd .. && flutter pub get && flutter pub upgrade && flutter packages get && flutter build ios $ENV
            break
            ;;
        *)
            echo "Invalid entry. Please choose again."
            ;;
        esac
    done
}

stage_pick
build_mode
