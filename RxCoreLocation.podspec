Pod::Spec.new do |s|
 s.name = 'RxCoreLocation'
 s.version = '0.39.3'
 s.license = { :type => "MIT", :file => "LICENSE" }
 s.summary = 'RxCoreLocation abstract the Rx behavior for Core Location'
 s.homepage = 'http://github.com/RxSwiftCommunity/RxCoreLocation'
 s.social_media_url = 'https://twitter.com/bobgodwinx'
 s.authors = { "Obi Bob Godwin" => "bobgodwinx@gmail.com" }
 s.source = { :git => "git@github.com:RxSwiftCommunity/RxCoreLocation.git", :tag => s.version.to_s }
 s.platforms     = { :ios => "9.3", :osx => "10.11", :tvos => "9.0", :watchos => "2.0" }
 s.requires_arc = true

 s.default_subspec = "Core"
 s.subspec "Core" do |ss|
     ss.source_files  = "Sources/*.swift"
     ss.framework  = "Foundation"
     ss.dependency "RxSwift", "~> 4.0"
     ss.dependency "RxCocoa", "~> 4.0"
 end

end
