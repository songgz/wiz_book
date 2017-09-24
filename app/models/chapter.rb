class Chapter
  include Mongoid::Document
  field :title, type: String
  field :cont, type: String

  belongs_to :volume
end
