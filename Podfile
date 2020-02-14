# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

inhibit_all_warnings!

target 'BTC' do
  use_frameworks!

  pod 'SnapKit', '5.0.1'
  pod 'FDTTableViewManager', '1.0.9'
  pod 'Starscream', '3.1.1'
  pod 'Dip', '7.0.1'

  target 'BTCTests' do
    inherit! :search_paths
    pod 'Quick', '2.2.0'
    pod 'Nimble', '8.0.4'
  end

end

plugin 'cocoapods-keys', {
  :project => "BTC",
  :keys => [
  "WebsocketPath",
  "ExampleRestApiPath"
  ]
}
