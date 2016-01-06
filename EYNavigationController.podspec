Pod::Spec.new do |spec|
  spec.name               = 'EYNavigationController'
  spec.version            = '0.0.1'
  spec.summary            = 'Reactive UINavigationController'
  spec.homepage           = 'https://github.com/seaburg/EYNavigationController'
  spec.license            =  { :type => "MIT", :file => "LICENSE" }
  spec.author             =  { "Evgeniy Yurtaev" => "evgeniyyurt@gmail.com" }
  spec.source             =  { :git => 'https://github.com/seaburg/EYNavigationController.git', :tag => '0.0.1' }
  spec.source_files       = 'EYNavigationController/*'
  spec.platform           = :ios, "6.0"
  spec.requires_arc       = true
  spec.dependency 'ReactiveCocoa'
end
