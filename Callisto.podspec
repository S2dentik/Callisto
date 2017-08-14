#
#  Be sure to run `pod spec lint Callisto.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "Callisto"
  s.version      = "0.0.1"
  s.summary      = "Parse .m3u8 playlists"
  s.homepage     = "https://github.com/S2dentik/Callisto.git"
  s.license      = "MIT"
  s.author       = { "Alexandru Culeva" => "alexandru.culeva@ellation.com" }
  s.source       = { :git => "https://github.com/S2dentik/Callisto.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.dependency "RxSwift", "~> 3.6.1"

end
