require 'rails_helper'

describe Review, type: :model do
	it "doesn't store an invalid review score" do
		review = Review.new(rating: 10) 
		expect(review).to have(1).error_on(:rating) 
	end
end