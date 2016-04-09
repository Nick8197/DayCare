workspace 'DayCare.xcworkspace'
platform :ios, "9.0"

use_frameworks!

inhibit_all_warnings!

xcodeproj 'DayCare/DayCare.xcodeproj'
xcodeproj 'DayCareClient/DayCareClient.xcodeproj'
xcodeproj 'Common/Common.xcodeproj'

target :Common do
xcodeproj 'Common/Common.xcodeproj'
pod 'Parse'
pod 'FormatterKit'
pod 'NYTPhotoViewer'
end

target :DayCare do
xcodeproj 'DayCare/DayCare.xcodeproj'

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
xcodeproj 'DayCareClient/DayCareClient.xcodeproj'
pod 'Fabric'
pod 'Crashlytics'

pod 'AFNetworking'
pod 'Parse'
pod 'XLForm'
pod 'MBProgressHUD'
pod 'FormatterKit'
pod 'NYTPhotoViewer'
end