Pod::Spec.new do |s|
  s.name         = 'YAJSONObject'
  s.version      = '1.1.0'
  s.license      =  { :type => 'MIT' }
  s.homepage     = 'https://github.com/delannoyk/YAJSONObject'
  s.authors      = {
    'Kevin Delannoy' => 'delannoyk@gmail.com'
  }
  s.summary      = 'Yet Another JSON Object.'

# Source Info
  s.platform     =  :ios, '8.0'
  s.source       =  {
    :git => 'https://github.com/delannoyk/YAJSONObject.git',
    :tag => s.version.to_s
  }
  s.source_files = 'YAJSONObject.swift'
  s.framework    =  'UIKit'

  s.requires_arc = true
end
