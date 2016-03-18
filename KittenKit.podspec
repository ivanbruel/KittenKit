Pod::Spec.new do |s|
  s.name         = "KittenKit"
  s.version      = "1.0.1"
  s.summary      = "KittenKit is an example of how to create a universal .framework file"
  s.description      = <<-DESC
KittenKit is an example of how to create a universal .framework file.
This is especially useful to distribute closed source swift frameworks.
                       DESC
  s.homepage     = "http://twitter.com/ivanbruel"
  s.license      = {
    :type => 'Copyright',
    :file => 'LICENSE'
  }
  s.social_media_url  = 'http://twitter.com/ivanbruel'
  s.author       = { "Ivan Bruel" => "ivan.bruel@gmail.com" }
  s.source       = { :git => "https://github.com/ivanbruel/KittenKit.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '9.0'
  s.frameworks = %w(Foundation)
  s.requires_arc = true
  s.ios.vendored_frameworks = 'KittenKit.framework'
  s.preserve_paths = 'KittenKit.framework'
end
