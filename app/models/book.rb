class Book < ApplicationRecord
  belongs_to :users, dependent: :destroy
end
