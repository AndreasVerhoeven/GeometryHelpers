Pod::Spec.new do |s|
    s.name             = 'SelfSizingScroller'
    s.version          = '1.0.0'
    s.summary          = 'Helpers for CGRect, CGSize, CGPoint and CGFloat'
    s.homepage         = 'hhttps://github.com/AndreasVerhoeven/GeometryHelpers'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Andreas Verhoeven' => 'cocoapods@aveapps.com' }
    s.source           = { :git => 'https://github.com/AndreasVerhoeven/GeometryHelpers.git', :tag => s.version.to_s }
    s.module_name      = 'GeometryHelpers'

    s.swift_versions = ['5.0']
    s.ios.deployment_target = '11.0'
    s.source_files = 'Sources/*.swift'
end
