# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'contentblocker' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for contentblocker

end

target 'LineBlock' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LineBlock
  # Pods for Branx
  pod 'Alamofire'
  pod 'Branch'
  pod 'Firebase/Core'
  pod 'Firebase/Performance'
  pod 'Firebase/RemoteConfig'
  pod 'IHProgressHUD', :git => 'https://github.com/Swiftify-Corp/IHProgressHUD.git'
  pod 'SwiftMessages'
  pod 'SwiftyStoreKit'
end
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      end
    end
  end
end