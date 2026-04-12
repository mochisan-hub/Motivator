class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :training_details, dependent: :destroy
    accepts_nested_attributes_for :training_details, allow_destroy: true
    has_many :post_comments, dependent: :destroy
    has_many :favorites, dependent: :destroy

    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end

    def self.search_for(content, method)
        if method == 'perfect'
            Post.where(title: content) # 完全一致
        elsif method == 'forward'
            Post.where('title LIKE ?', content + '%')# 前方一致
        elsif method == 'backward'
            Post.where('title LIKE ?', '%' + content) # 後方一致
        else
            Post.where('title LIKE ?', '%' + content + '%') # 部分一致
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
