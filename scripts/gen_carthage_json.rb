require 'nokogiri'
require 'open-uri'
require 'json'

changelog_url = 'https://docs.fabric.io/apple/changelog.html'

binary_url_by_framework = {
  "Answers" => "https://kit-downloads.fabric.io/ios/com.twitter.answers.ios/%s/com.twitter.answers.ios-default.zip",
  "Crashlytics" => "https://kit-downloads.fabric.io/ios/com.twitter.crashlytics.ios/%s/com.twitter.crashlytics.ios-default.zip",
  "Fabric" => "https://kit-downloads.fabric.io/ios/io.fabric.sdk.ios/%s/io.fabric.sdk.ios-default.zip"
}

charset = nil

html = open(changelog_url) do |f|
    charset = f.charset
    f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)

framework_section_nodes = doc.xpath("//div[@id='changelog']/div[@class='section']")

framework_section_nodes.each do |node|
  framework_name = node.xpath("h2").text.delete("¶")

  json_path = File.expand_path("../../#{framework_name}.json", __FILE__)
  
  json = JSON.pretty_generate(
    node.xpath("div[@class='section']")
      .map { |node| node.xpath("h3").text[/(([0-9]+\.[0-9]+\.[0-9]+))/, 1] }
      .map { |version| [version, binary_url_by_framework[framework_name] % version] }
      .to_h
  )

  File.open(json_path, "w") do |f|
    f.write(json)
  end
end
