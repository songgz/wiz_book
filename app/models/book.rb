class Book
  include Mongoid::Document
  field :title, type: String
  field :intro, type: String

  has_many :volumes, dependent: :destroy
end
