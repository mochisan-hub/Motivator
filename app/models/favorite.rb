class Favorite < ApplicationRecord

    belong_to :user
    belong_to :post     

    varidates :user_id, uniqueness: {scope: :post_id}

end
