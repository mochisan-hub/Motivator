class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :training_details, dependent: :destroy
    accepts_nested_attributes_for :training_details, allow_destroy: true
    has_many :post_comments, dependent: :destroy
    
    def get_image
        unless image.attached?
            file_path = Rails.root.join('app/assets/images/no_image.jpg')
            image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        image
    end
end
