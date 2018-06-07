
Pod::Spec.new do |s|


  s.name         = "XCPhotoesView"
  s.version      = "1.0.5"
  s.summary      = "XCPhotoesView."

  s.description  = <<-DESC
	XCPhotoesView 图片排列框架
                   DESC

  s.homepage     = "https://github.com/fanxiaocong/XCPhotoesView"

  s.license      = "MIT"

  s.author             = { "樊小聪" => "1016697223@qq.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/fanxiaocong/XCPhotoesView.git", :tag => "#{s.version}" }

  s.source_files  = "XCPhotoesView/**/*.{h,m}"

end
