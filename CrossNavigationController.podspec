Pod::Spec.new do |s|
  s.name         = "CrossNavigationController"
  s.version      = "0.5.0"
  s.summary      = "Move to cross using UINavigationController."
  s.homepage     = "https://github.com/hryk224/CrossNavigationController"
  s.screenshots  = "https://github.com/hryk224/CrossNavigationController/wiki/images/sample.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "hyyk224" => "hryk224@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/hryk224/CrossNavigationController.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/*.{h,swift}"
  s.frameworks = "UIKit"
  s.requires_arc = true
end
