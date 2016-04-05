workspace 'DayCare.xcworkspace'
platform :ios, "9.0"

use_frameworks!

inhibit_all_warnings!

xcodeproj 'CareTaker/CareTaker.xcodeproj'
xcodeproj 'Parents/DayCareClient.xcodeproj'

target :CareTaker do
xcodeproj 'CareTaker/CareTaker.xcodeproj'
pod 'AFNetworking'
pod 'Parse'
pod 'XLForm'
end

target :DayCareClient do
xcodeproj 'Parents/DayCareClient.xcodeproj'
pod 'AFNetworking'
pod 'Parse'
end