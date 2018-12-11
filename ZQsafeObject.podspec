

Pod::Spec.new do |s|



  s.name         = "ZQsafeObject"
  s.version      = "1.0.0"
  s.summary      = "安全数组/字典/set"


  s.description  = <<-DESC
        多线程下安全的数组/字典/set
            DESC

  s.homepage     = "https://github.com/Kssss"




  s.license      = "MIT"



  s.author             = { "谭建中" => "5652903@qq.com" }

  s.platform     = :ios, "8.0"



  s.source       = { :git => "https://github.com/Kssss/ZQsafeObject.git", :tag => "1.0.0" }



  s.source_files  = "Classes", "ZQsafeObject/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.requires_arc = true #是否支持ARC


end
