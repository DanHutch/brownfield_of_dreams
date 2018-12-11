class Apikey < ApplicationRecord
  validates_presence_of :host, :key, :uid
  belongs_to :user

  enum host: [:github]

end
