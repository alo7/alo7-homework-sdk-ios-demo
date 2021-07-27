# Uncomment the next line to define a global platform for your project
install! 'cocoapods'
platform :ios, '10.0'
source 'https://github.com/alo7/ios-repo.git'
source 'https://cdn.cocoapods.org/'

target 'Alo7HomeworkSDKDemo' do
  use_frameworks!
  pod 'Alo7HomeworkSDK'
end

# 由于Apple关于新上APP禁止使用UIWebview，添加下面代码删除UIWebview相关代码
pre_install do |installer|
  installer.pod_targets.each do |target|
    if target.name == 'WebViewJavascriptBridge'
      target.all_files.each do |file|
        if file.match?(/\/WebViewJavascriptBridge\.[hm]$/)
          File.delete(file)
        end
      end
    end
  end
end

### 若项目中有使用RXSwift则需要在podfile中加入下面这段
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if ['RxSwift', 'RxCocoa', 'RxRelay'].include?(target.name)
          config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = "YES"
      end
    end
  end
end
