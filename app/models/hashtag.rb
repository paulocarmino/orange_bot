class Hashtag < ActiveRecord::Base
  validates_presence_of :name

  has_many :faq_hashtags
  has_many :hashtags, through: :faq_hashtags
  belongs_to :company
end
