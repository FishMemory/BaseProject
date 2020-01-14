platform:ios,'8.1'
inhibit_all_warnings!
project '../BasicProject/BasicProject.xcodeproj'
use_frameworks!
source 'https://github.com/CocoaPods/Specs.git'
target 'BasicProject' do
#	pod 'Reachability', '~> 3.2'
	pod 'AFNetworking', '~> 3.0.4'
	pod 'IQKeyboardManager'
  pod 'Masonry'
  pod 'MBProgressHUD'
  pod 'MJExtension'
	pod 'MJRefresh'
	pod 'SDWebImage'
  pod 'ZZFLEX', :git => 'https://github.com/tbl00c/ZZFLEX.git'
  pod 'TZImagePickerController'
  pod 'SDCycleScrollView'
end
post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['ENABLE_BITCODE'] = 'NO'
end
end
end

