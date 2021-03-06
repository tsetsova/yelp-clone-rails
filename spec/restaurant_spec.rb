require 'rails_helper'

describe Restaurant, type: :model do
  it {is_expected.to have_many(:reviews).dependent(:destroy)}

  it "can't have a name with less than three characters" do
  	restaurant = Restaurant.new(name: "kf")
  	expect(restaurant).to have(1).error_on(:name)
  	expect(restaurant).not_to be_valid 
  end

  it "can't have the same name as an existing restaurant" do
  	 Restaurant.create(name: "Hungry Donkey")
  	 restaurant = Restaurant.new(name: "Hungry Donkey")
  	 expect(restaurant).to have(1).error_on(:name)
  	 expect(restaurant).not_to be_valid 
  end
end
