Pod::Spec.new do |spec|
  spec.name     = 'NaradaBotCore'
  spec.version  = '1.0.0'
  spec.summary  = 'Generic chat interface for creating chatbots using api.ai'
  spec.homepage = 'https://github.com/Visual-Engineering'
  spec.license  = { type: 'Apache License, Version 2.0', file: 'LICENSE' }
  spec.authors  = { 'Visual-Engineering' => 'ios@visual-engin.com' }

  spec.platform     = :ios, '10.0'
  spec.framework    = 'Foundation'
  spec.requires_arc = true
  spec.source       = { :path => '.' }
  spec.source_files = '**/*.{h,m,swift}'

  spec.dependency 'VisualEnginApiAI'
  spec.dependency 'SDWebImage'
  spec.dependency 'JSQMessagesViewController'

end