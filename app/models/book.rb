class Book < ApplicationRecord
  has_one_attached :image
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200}
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  
  def favorited_by?(user)
   favorites.exists?(user_id: user.id)
  end
  
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%' + content)
    else
      Book.where('title LIKE ?', '%' + content + '%')
    end
  end
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
  
