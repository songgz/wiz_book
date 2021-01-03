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
    if res.code == "301"
      res = Net::HTTP.get_response(URI.parse(res.header['location']))
    end
    res.body
  end

end