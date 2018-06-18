class User < ApplicationRecord
	has_many :user_results, dependent: :destroy
	has_many :user_answers, dependent: :destroy
end
