Pod::Spec.new do |spec|
  spec.name = "DotstudioAPI"
  spec.version = "0.0.1"
  spec.summary = "Dotstudio API framework for mobile apps."
  spec.homepage = "https://github.com/dotstudiopro/DotstudioAPI_iOS"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Ketan Sakariya" => 'ketan@dotstudiopro.com' }
#   spec.social_media_url = "http://twitter.com/ketansakariya"

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/dotstudiopro/ios-api.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "source/**/*.{h,swift}"

  spec.dependency "Alamofire", "~> 4.0"
end


