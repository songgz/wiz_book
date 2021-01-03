class Chapter
  include Mongoid::Document
  field :title, type: String
  field :cont, type: String

  belongs_to :volume

  def content
    cont.gsub(/\r\n/, '<br /><br />')
  end
end
