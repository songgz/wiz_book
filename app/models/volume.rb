class Volume
  include Mongoid::Document
  field :title, type: String
  field :intro, type: String

  belongs_to :book
  has_many :chapters, dependent: :delete
end
