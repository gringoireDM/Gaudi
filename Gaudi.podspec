Pod::Spec.new do |s|

    s.version = "1.0.0"
    s.ios.deployment_target = '11.0'
    s.name = "Gaudi"
 	s.summary = "A swift theming framework for UIKit for easy adoption of multi theme and iOS dark mode"
	s.swift_version = '5.1'
    
  	s.description  = <<-DESC
                   Gaudí is a framework for theme management in UIKit. It allows to easily swap themes in runtime, revert theming applied through UIAppearance proxies.

                   Gaudí also provides a DSL for UIAppearance rules and NSAttributedString.

                   This framework uses semantic colors names to better adapt to dark mode and other possible themes living within the same app.
                   DESC
                   
    s.requires_arc = true

    s.license = { :type => "MIT" }
	s.homepage = "https://www.pfrpg.net"
    s.author = { "Giuseppe Lanza" => "gringoire986@gmail.com" }

    s.source = {
        :git => "https://github.com/gringoireDM/Gaudi.git",
        :tag => s.version.to_s
    }
    
    s.source_files = "Sources/**/*.swift"
end
