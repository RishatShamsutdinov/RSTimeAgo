Pod::Spec.new do |s|
  s.name         = "RSTimeAgo"
  s.version      = "0.1.2"
  s.summary      = "Util for time ago labels."

  s.description  = <<-DESC
                   Util for time ago labels. Uses ctime.
                   DESC

  s.homepage     = "https://github.com/RishatShamsutdinov/RSTimeAgo"

  s.license      = "Apache License, Version 2.0"

  s.author       = { "Rishat Shamsutdinov" => "dichat.dark@gmail.com" }

  s.platform     = :ios, "7.1"

  s.source       = { :git => "https://github.com/RishatShamsutdinov/RSTimeAgo.git", :tag => "v" + s.version.to_s }

  s.source_files = "RSTimeAgo/**/*.{h,m}"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true

  # s.dependency "RSFoundationUtils", "~> 0.1"

end
