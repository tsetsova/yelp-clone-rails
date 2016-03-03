require "rails_helper"

xdescribe User do
	# it { is_expected.to have_many :reviewed_restaurants}
	it { is_expected.to have_many :reviews}
end