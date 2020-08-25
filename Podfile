# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def shared_pods
  pod 'Moya'
  pod 'HandyJSON'
  pod 'SwiftyJSON'
  pod 'SwiftSoup'
  pod 'SwifterSwift'
  pod 'Reusable'
  pod 'SnapKit'
  pod 'Kingfisher'
  pod "ESPullToRefresh"
  pod 'PKHUD'
  pod 'Segmentio'
  pod 'CHTCollectionViewWaterfallLayout/Swift'
  pod 'PanModal'
  pod 'DZNEmptyDataSet'
end

target 'Deviant' do
  inhibit_all_warnings!
  use_frameworks!
  shared_pods
end

target 'DeviantTests' do
  inhibit_all_warnings!
  use_frameworks!
  shared_pods
end

target 'DeviantUITests' do
  inhibit_all_warnings!
  use_frameworks!
  shared_pods
  pod 'iOSSnapshotTestCase'
end
