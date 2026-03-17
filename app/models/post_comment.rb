class PostComment < ApplicationRecord
    belong_to :user
    belong_to :post
end
