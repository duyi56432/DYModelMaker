
Pod::Spec.new do |s|


  s.name         = "DYModelMaker"
  s.version      = "1.0.1"
  s.summary      = "字典生成模型，支持多层模型嵌套,自动实现归档、解档,实现模型直接的赋值、深复制"

  s.description  = <<-DESC
                    字典生成模型，支持多层模型嵌套,自动生成两种框架（MJExtension和YYModel）的系统关键字替换和数组中字典转模型代码,自动实现归档、解档,实现模型直接的赋值、深复制
                   DESC

  s.homepage     = "https://github.com/duyi56432/DYModelMaker"

  s.license      = "MIT"

  s.author             = { "duyi56432" => "564326678@qq.com" }
  s.frameworks   = "Foundation"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/duyi56432/DYModelMaker.git", :tag => "#{s.version}" }


  s.source_files  = "DYModelMaker/**/*.{h,m}"


end
