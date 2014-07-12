 
Pod::Spec.new do |s|
 

  s.name         = "DYCategory-Additions"
  s.version      = "1.0.1"
  s.summary      = "DYCategory-Additions  collection"
 

  s.homepage     = "https://github.com/junhaiyang/DYCategory-Additions"
 
  s.license      = "MIT"
 
  s.author             = { "yangjunhai" => "junhaiyang@gmail.com" } 
  s.ios.deployment_target = "6.0" 

 
  s.source = { :git => 'https://github.com/junhaiyang/DYCategory-Additions.git' , :tag => '1.0.1'} 
 
  s.requires_arc = true
  
  
  s.subspec 'Math' do |sbs|
   
  	sbs.subspec 'Math+Degrees' do |tbs|
 
    	tbs.source_files = 'Category/Math/Math+Degrees/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
  
  s.subspec 'NSAttributedString' do |sbs|
   
  	sbs.subspec 'NSAttributedString+Attributes' do |tbs|
 
    	tbs.source_files = 'Category/NSAttributedString/NSAttributedString+Attributes/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
  
  s.subspec 'NSData' do |sbs|
   
  	sbs.subspec 'NSData+AES' do |tbs|
 
    	tbs.source_files = 'Category/NSData/NSData+AES/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
  
  s.subspec 'NSDate' do |sbs|
   
  	sbs.subspec 'NSDate+Translator' do |tbs|
 
    	tbs.source_files = 'Category/NSDate/NSDate+Translator/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
  
  s.subspec 'NSDictionary' do |sbs|
   
  	sbs.subspec 'NSDictionary+JSON' do |tbs|
 
    	tbs.source_files = 'Category/NSDictionary/NSDictionary+JSON/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
   
  s.subspec 'NSNumber' do |sbs|
   
  	sbs.subspec 'NSNumber+Date' do |tbs|
 
    	tbs.source_files = 'Category/NSNumber/NSNumber+Date/*.{h,m,mm}'  
    	 
  	end 
  	sbs.subspec 'NSNumber+Random' do |tbs|
 
    	tbs.source_files = 'Category/NSNumber/NSNumber+Random/*.{h,m,mm}'  
    	 
  	end 
    		 
  end
   
  s.subspec 'NSString' do |sbs|
   
  	sbs.subspec 'NSString+BOOL' do |tbs|
 
    	tbs.source_files = 'Category/NSString/NSString+BOOL/*.{h,m,mm}'  
    	 
  	end 
  	
  	sbs.subspec 'NSString+Blank' do |tbs|
 
    	tbs.source_files = 'Category/NSString/NSString+Blank/*.{h,m,mm}'  
    	
     	tbs.dependency 'DYCategory-Additions/NSString/NSString+BOOL'
    	 
  	end 
   
  	sbs.subspec 'NSString+Contains' do |tbs|
 
    	tbs.source_files = 'Category/NSString/NSString+Contains/*.{h,m,mm}'  
    	 
  	end 
  	sbs.subspec 'NSString+Version' do |tbs|
 
    	tbs.source_files = 'Category/NSString/NSString+Version/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
     
  s.subspec 'UIApplication' do |sbs|
   
  	sbs.subspec 'UIApplication+LHSAdditions' do |tbs|
 
    	tbs.source_files = 'Category/UIApplication/UIApplication+LHSAdditions/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
     
  s.subspec 'UIColor' do |sbs|
   
  	sbs.subspec 'UIColor+Extras' do |tbs|
 
    	tbs.source_files = 'Category/UIColor/UIColor+Extras/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
     
  s.subspec 'UIDevice' do |sbs|
   
  	sbs.subspec 'UIDevice+Extras' do |tbs|
 
    	tbs.source_files = 'Category/UIDevice/UIDevice+Extras/*.{h,m,mm}'  
    	 
  	end 
   
  	sbs.subspec 'UIDevice+Resolutions' do |tbs|
 
    	tbs.source_files = 'Category/UIDevice/UIDevice+Resolutions/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
     
  s.subspec 'UIFont' do |sbs|
   
  	sbs.subspec 'UIFont+LHSAdditions' do |tbs|
 
    	tbs.source_files = 'Category/UIFont/UIFont+LHSAdditions/*.{h,m,mm}'  
    	 
  	end 
    		 
  end
     
  s.subspec 'UIImage' do |sbs|
   
  	sbs.subspec 'UIImage+LHSAdditions' do |tbs|
 
    	tbs.source_files = 'Category/UIImage/UIImage+LHSAdditions/*.{h,m,mm}'  
    	 
  	end 
   
  	sbs.subspec 'UIImage+ScaleClip' do |tbs|
 
    	tbs.source_files = 'Category/UIImage/UIImage+ScaleClip/*.{h,m,mm}'  
    	 
  	end 
   
  	sbs.subspec 'UIImageExtras' do |tbs|
 
    	tbs.source_files = 'Category/UIImage/UIImageExtras/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
  
  
  s.subspec 'ALAsset' do |sbs|
   
  	sbs.subspec 'ALAsset+Extras' do |tbs|
  	
     	tbs.dependency 'DYCategory-Additions/UIImage/UIImage+ScaleClip'
     	tbs.dependency 'DYCategory-Additions/UIImage/UIImageExtras'
 
    	tbs.source_files = 'Category/ALAsset/ALAsset+Extras/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
     
  s.subspec 'UINavigationController' do |sbs|
   
  	sbs.subspec 'UINavigationController+Extra' do |tbs|
 
    	tbs.source_files = 'Category/UINavigationController/UINavigationController+Extra/*.{h,m,mm}'  
    	 
  	end 
    		 
  end
     
  s.subspec 'UIScreen' do |sbs|
   
  	sbs.subspec 'UIScreen+LHSAdditions' do |tbs|
 
    	tbs.source_files = 'Category/UIScreen/UIScreen+LHSAdditions/*.{h,m,mm}'  
    	 
  	end 
    		 
  end
     
  s.subspec 'UIView' do |sbs|
   
  	sbs.subspec 'UIView+Click' do |tbs|
 
    	tbs.source_files = 'Category/UIView/UIView+Click/*.{h,m,mm}'  
    	 
  	end 
   
  	sbs.subspec 'UIView+Extras' do |tbs|
 
    	tbs.source_files = 'Category/UIView/UIView+Extras/*.{h,m,mm}'  
    	 
  	end 
   
  	sbs.subspec 'UIView+LHSAdditions' do |tbs|
 
    	tbs.source_files = 'Category/UIView/UIView+LHSAdditions/*.{h,m,mm}'  
    	 
  	end 
    		 
  end 
   
  s.subspec 'UIViewController' do |sbs|
   
  	sbs.subspec 'UIViewController+LHSAdditions' do |tbs|
 
    	tbs.source_files = 'Category/UIViewController/UIViewController+LHSAdditions/*.{h,m,mm}'  
    	 
  	end 
    		 
  end
 
end
