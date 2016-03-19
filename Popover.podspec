Pod::Spec.new do |s|
  s.name = "Popover"
  s.version = "0.1"
  s.license = "MIT"
  s.summary = "Popover is an UIPopoverController like control for iOS."
  s.homepage = "https://github.com/cuzv/Popover"
  s.author = { "Moch Xiao" => "cuzval@gmail.com" }
  s.source = { :git => "https://github.com/cuzv/Popover.git", :tag => s.version }

  s.ios.deployment_target = "8.0"
  s.source_files = "Popover/Sources/*.swift"
  s.requires_arc = true
end
