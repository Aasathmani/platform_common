#!/bin/bash

# Read the user input

echo "Enter the Build Format: 1.APK & IPA 2.APK 3.AppBundle 4.IPA 5.Windows"
read buildFormatValue
echo "Flavor : 1.QA 2.Dev 3.Staging 4.Production"
read flavorValue
echo "Build Number :"
read buildNumber
echo "Release Type : 1.Release 2.Debug 3.Profile"
read releaseTypeValue

case $buildFormatValue in
    2)
       buildFormat='apk'
        ;;
    3)
       buildFormat='appbundle'
        ;;
    4)
       buildFormat='ipa'
        ;;
    5)
       buildFormat='windows'
        ;;
esac

case $flavorValue in
    1)
        flavor='qa'
        path='lib/main_qa.dart'
        ;;
    2)
        flavor='development'
        path='lib/main_dev.dart'
        ;;
    3)
        flavor='staging'
        path='lib/main_staging.dart'
        ;;
    4)
        flavor='production'
        path='lib/main_prod.dart'
        ;;
esac

case $releaseTypeValue in
    1)
       releaseType='release'
        ;;
    2)
       releaseType='debug'
        ;;
    3)
       releaseType='profile'
        ;;
esac

case $buildFormatValue in
    1)
        echo "flutter build ipa --$releaseType -t $path --flavor $flavor --build-number $buildNumber --export-method ad-hoc"
        flutter build ipa --$releaseType -t $path --flavor $flavor --build-number $buildNumber --export-method ad-hoc
        echo "flutter build apk --$releaseType -t $path --flavor $flavor --build-number $buildNumber"
        flutter build apk --$releaseType -t $path --flavor $flavor --build-number $buildNumber
        ;;
    2)
        echo "flutter build $buildFormat --$releaseType -t $path --flavor $flavor --build-number $buildNumber"
        flutter build $buildFormat --$releaseType -t $path --flavor $flavor --build-number $buildNumber
        ;;
    3)
        echo "flutter build $buildFormat --$releaseType -t $path --flavor $flavor --build-number $buildNumber"
        flutter build $buildFormat --$releaseType -t $path --flavor $flavor --build-number $buildNumber
        ;;
    4)
        echo "flutter build $buildFormat --$releaseType -t $path --flavor $flavor --build-number $buildNumber --export-method ad-hoc"
        flutter build $buildFormat --$releaseType -t $path --flavor $flavor --build-number $buildNumber --export-method ad-hoc
        ;;
    5)
        echo "flutter build $buildFormat --$releaseType -t $path --build-number $buildNumber"
        flutter build $buildFormat --$releaseType -t $path --build-number $buildNumber
        ;;
esac
#
#if [ "$buildFormatValue" -eq 3 ]; then
#  echo "flutter build $buildFormat --$releaseType -t $path --flavor $flavor --build-number $buildNumber --export-method ad-hoc"
#  flutter build $buildFormat --$releaseType -t $path --flavor $flavor --build-number $buildNumber --export-method ad-hoc
#else
#  echo "flutter build $buildFormat --$releaseType -t $path --flavor $flavor --build-number $buildNumber"
#  flutter build $buildFormat --$releaseType -t $path --flavor $flavor --build-number $buildNumber
#fi


