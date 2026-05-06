class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
   has_one_attached :profile_image
   has_many :posts, dependent: :destroy
   has_many :post_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_many :followings, dependent: :destroy, class_name: "Relationship", foreign_key: :follower_id
   has_many :following_users, through: :followings, source: :followed
   has_many :followers, dependent: :destroy, class_name: "Relationship", foreign_key: :followed_id
   has_many :follower_users, through: :followers, source: :follower

   enum membership_states: { active: 0, withdrawn: 1 }

   #def active_for_authentication?
   # super && (self.active?)
   #end

   def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

   def get_profile_image(width,height)
      unless profile_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
        profile_image.variant(resize_to_limit: [width,height]).processed
   end

  def follow(user)
    followings.find_or_create_by(followed: user)
  end

  def unfollow(user)
    followings.find_by(followed: user)&.destroy
  end

  def following?(user)
    following_users.include?(user)
  end

  def self.guest
    user = self.find_or_initialize_by(email: "guest@test.com")
    user.assign_attributes(
    password: SecureRandom.hex(6),
    name: "ゲスト"
    )
    user.save
    user
  end

end
