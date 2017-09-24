namespace :zhongyf do
  desc "this is also describe"
  task mongodb: :environment do
    z = Zhongyf.new('http://www.zhongyf.com/books/guji/lzhsyl/')
    z.get_title
    z.get_intro
    z.get_volume
    z.to_db
  end
end
