namespace :zhongyf do
  desc "this is also describe"
  task mongodb: :environment do
    list = [
        'http://www.zhongyf.com/books/guji/frdqlf/',
        'http://www.zhongyf.com/books/guji/tphm/',
        'http://www.zhongyf.com/books/guji/lzhzhn/'
    ]
    Zhongyf.new()

  end
end
