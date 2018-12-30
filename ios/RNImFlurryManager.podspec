
Pod::Spec.new do |s|
  s.name         = "RNImFlurryManager"
  s.version      = "1.0.0"
  s.summary      = "RNImFlurryManager"
  s.description  = <<-DESC
                  RNImFlurryManager
                   DESC
  s.homepage     = ""
  s.license      = {  :type => 'Apache License, Version 2.0',
                                         :text => <<-LICENSE
                                           Copyright 2018, Mokhlas Hussein.

                                           Licensed under the Apache License, Version 2.0 (the "License");
                                           you may not use this file except in compliance with the License.
                                           You may obtain a copy of the License at

                                             http://www.apache.org/licenses/LICENSE-2.0

                                           Unless required by applicable law or agreed to in writing, software
                                           distributed under the License is distributed on an "AS IS" BASIS,
                                           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
                                           See the License for the specific language governing permissions and
                                           limitations under the License.
                                         LICENSE
                                       }
  s.author             = { "iMokhles" => "mokhleshussien@aol.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/author/RNImFlurryManager.git", :tag => "master" }
  s.source_files  = "RNImFlurryManager/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  s.dependency "Flurry-iOS-SDK/FlurrySDK"
  s.dependency "Flurry-iOS-SDK/FlurryAds"

end

  