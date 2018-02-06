class Message < ApplicationRecord

  validates :text_or_image, presence: true
  belongs_to :user
  belongs_to :group
  mount_uploader :image, ImageUploader

  private
  def text_or_image
    text.presence or image.presence
  end
end
