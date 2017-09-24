class XmlHttp

  def self.get(path)
    begin
      uri = URI(path)
    rescue
      return ''
    end
    req = Net::HTTP::Get.new(uri)
    res = Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(req)
    end
    res.body
  end

end