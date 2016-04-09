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
pod 'FormatterKit'
pod 'NYTPhotoViewer'
end

target :CareTaker do
xcodeproj 'CareTaker/CareTaker.xcodeproj'

pod 'Fabric'
pod 'Crashlytics'

pod 'AFNetworking'
pod 'Parse'
pod 'XLForm'
pod 'MBProgressHUD'
pod 'FormatterKit'
pod 'UITextView+Placeholder'
pod 'NYTPhotoViewer'
end

target :DayCareClient do
xcodeproj 'Parents/DayCareClient.xcodeproj'
pod 'Fabric'
pod 'Crashlytics'

pod 'AFNetworking'
pod 'Parse'
pod 'XLForm'
pod 'MBProgressHUD'
pod 'FormatterKit'
pod 'NYTPhotoViewer'
end