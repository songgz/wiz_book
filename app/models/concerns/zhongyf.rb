# coding: utf-8
class Zhongyf
  attr_reader :book

  def initialize(urls = [])
    urls = get_books() if urls.blank?
    urls.each do |url|
      get_book(url)
      p get_title
      get_intro
      get_volume
      to_db
    end
  end

  def get_books(url = 'http://www.zhongyf.com/books/guji/')
    data = XmlHttp.get(url)
    html = Nokogiri::HTML(data)
    links = html.xpath('//table[@class="box"]//div[@class="daodu"]/u/li/a')
    index = links.index {|l| l.attr('href') == '/books/guji/bcxbl/'}
    books = []
    links.each_with_index do |a, i|
      books << 'http://www.zhongyf.com' + a.attr('href') if i > index
    end
    books
  end

  def get_book(url)
    data = XmlHttp.get(url)
    html = Nokogiri::HTML(data)
    @text = html.xpath('//table[@class="box"]')
    @book = {
        title: '',
        intro: '',
        volums: []
    }
  end

  def get_title
    @book[:title] = @text.xpath('//h1').text
  end

  def get_intro
    @book[:intro] = @text.xpath('//div[@class="daodu"]').text
  end

  def get_volume
    rows = @text.xpath('//table[@id="myBook"]/tr/td')
    (rows.size/2).times do |i|
      p i
      n = (i+1) * 2 - 2
      v = {title: rows[n].text.lstrip.rstrip, chapters: []}
      rows[n + 1].xpath('./ul/li/a').each do |c|
        v[:chapters] << {title: c.text, cont: get_chapter(c.attr('href'))}
      end
      @book[:volums] << v
    end
  end

  def get_chapter(url)
    data = XmlHttp.get('http://www.zhongyf.com' + url)
    html = Nokogiri::HTML(data)
    html = html.xpath('//td[@id="text"]')
    html.xpath('.//div[@class="daodu"]').remove
    text = html.children.map {|d| d.text}.join("\r\n")
  end

  def to_file
    f = File.new('d:/Test.txt',"w+")
    f.puts @book[:title]
    f.puts @book[:intro]
    @book[:volums].each do |v|
      f.puts v[:title]
      v[:chapters].each do |c|
        f.puts c[:title]
        f.puts c[:cont]
      end
    end
  end

  def to_db
    book = Book.create(title: @book[:title], intro: @book[:intro])
    @book[:volums].each do |v|
      volume = book.volumes.create(title: v[:title])
      v[:chapters].each do |c|
        volume.chapters.create(title: c[:title], cont: c[:cont])
      end
    end
  end

end