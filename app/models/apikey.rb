class Apikey < ApplicationRecord
  validates_presence_of :host, :key
  belongs_to :user

  enum host: [:gitub]

end
