require 'rails_helper.rb'

feature 'restaurants' do
	context 'no restaurants have been added' do
		scenario 'should desplay a prompt to add a restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurant yet!'
			expect(page).to have_link 'Add a restaurant'
		end
	end
	context 'restaurants have been added' do
		before do
			Restaurant.create(name: 'KFC')
		end

		scenario 'display restaurants' do
			visit '/restaurants'
			expect(page).to have_content('KFC')
			expect(page).not_to have_content('No restaurant yet!')
		end
	end
end