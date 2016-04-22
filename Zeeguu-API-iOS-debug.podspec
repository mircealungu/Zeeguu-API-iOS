Pod::Spec.new do |s|
  s.name         = "Zeeguu-API-iOS-debug"
  s.version      = "1.0.3"
  s.summary      = "An API for Zeeguu for iOS"
  s.description  = <<-DESC
  				   The iOS Framework that acts as a layer in front of the Zeeguu server.
                   DESC
  s.homepage     = "https://github.com/JorritO/Zeeguu-API-iOS"
  s.license      = "MIT"
  s.author    = "Mircea Filip Lungu"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/JorritO/Zeeguu-API-iOS.git", :tag => "1.0.3" }
  s.source_files  = "ZeeguuAPI/ZeeguuAPI/*.{swift,h}"
  s.dependency 'SwiftyJSON', '~> 2.3'
end
