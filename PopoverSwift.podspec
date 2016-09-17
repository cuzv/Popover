Pod::Spec.new do |s|
  s.name = "PopoverSwift"
  s.version = "1.0.0"
  s.license = "MIT"
  s.summary = "PopoverSwift is an UIPopoverController like control for iOS."
  s.homepage = "https://github.com/cuzv/Popover"
  s.author = { "Moch Xiao" => "cuzval@gmail.com" }
  s.source = { :git => "https://github.com/cuzv/Popover.git", :tag => s.version }

  s.ios.deployment_target = "8.0"
  s.source_files = "PopoverSwift/Sources/*.swift"
  s.requires_arc = true
end
