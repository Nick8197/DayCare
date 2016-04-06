workspace 'DayCare.xcworkspace'
platform :ios, "9.0"

use_frameworks!

inhibit_all_warnings!

xcodeproj 'CareTaker/CareTaker.xcodeproj'
xcodeproj 'Parents/DayCareClient.xcodeproj'
xcodeproj 'Common/Common.xcodeproj'

target :Common do
xcodeproj 'Common/Common.xcodeproj'
pod 'Parse'
end

target :CareTaker do
xcodeproj 'CareTaker/CareTaker.xcodeproj'
pod 'AFNetworking'
pod 'Parse'
pod 'XLForm'
pod 'Fabric'
pod 'Crashlytics'
end

target :DayCareClient do
xcodeproj 'Parents/DayCareClient.xcodeproj'
pod 'AFNetworking'
pod 'Parse'
pod 'Fabric'
pod 'Crashlytics'
end