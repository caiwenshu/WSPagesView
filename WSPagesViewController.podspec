#
# Be sure to run `pod lib lint MyLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "WSPagesViewController"
s.version          = "0.0.1"
s.summary          = "pages view"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
s.description      = <<-DESC
    pages view for slide.
DESC

s.homepage         = "https://github.com/caiwenshu/WSPagesViewController.git"
s.license          = 'MIT'
s.author           = { "caiwenshu" => "wenshu.cai@gmail.com" }
s.source           = { :git => "https://github.com/caiwenshu/WSPagesViewController.git", :tag => s.version.to_s }

s.requires_arc = true

s.public_header_files = "WSPagesViewController/**/*.h"
s.source_files = "WSPagesViewController/**/*.{h,m}"
s.resource_bundles = {
'pro' => ['WSPagesViewController/*.png']
}

end
