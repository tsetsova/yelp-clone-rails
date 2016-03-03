require 'rails_helper.rb'

feature 'restaurants' do

	context "logged out users can't create a restaurant" do
		scenario 'should desplay a prompt to add a restaurant' do
			visit '/restaurants'
			click_link 'Add a restaurant'
			expect(page).not_to have_content 'KFC'

		end
	end

	context 'restaurants have been added' do
		before do
			Restaurant.create(name: 'KFC')
		end

		scenario 'display restaurants' do
			visit '/restaurants'
			expect(page).not_to have_button('Create Restaurant')
		end
	end

	context 'creating restaurants' do

		before(:each) {sign_up}

		scenario 'prompts user to fill out a form, then displays the new restaurant' do
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq '/restaurants'
		end

		context 'adding an invalid restaurant' do
			scenario 'with less than 2 characters' do
				visit '/restaurants'
				click_link 'Add a restaurant'
				fill_in 'Name', with: 'kf'
				click_button 'Create Restaurant'
				expect(page).not_to have_css 'h2', text: "kf" 
				expect(page).to have_content 'error'
			end

			scenario 'with same name as existing entry' do
				Restaurant.create(name:'KFC')
				visit '/restaurants'
				click_link 'Add a restaurant'
				fill_in 'Name', with: 'KFC'
				click_button 'Create Restaurant'
				expect(page).to have_content 'error'
			end
		end
	end

	context 'viewing restaurants' do

	let!(:kfc){Restaurant.create(name:'KFC')}

	  scenario 'lets a user view a restaurant' do
		  sign_up
		  visit '/restaurants'
		  click_link 'KFC'
		  expect(page).to have_content 'KFC'
		  expect(current_path).to eq "/restaurants/#{kfc.id}"
	  end
	end

	context 'editing restaurants' do
		before { Restaurant.create name:'KFC'}

		scenario 'let user edit a restaurant' do
			sign_up
			click_link 'Edit KFC'
			fill_in 'Name', with: 'Kentucky Fried Chicken'
			click_button 'Update Restaurant'
			expect(page).to have_content 'Kentucky Fried Chicken'
			expect(current_path).to eq '/restaurants'
		end
	end

	context 'deleting restaurants' do

	  before {Restaurant.create name: 'KFC'}

	  scenario 'removes a restaurant when a user clicks a delete link' do
	  	sign_up
	    click_link 'Delete KFC'
	    expect(page).not_to have_content 'KFC'
	    expect(page).to have_content 'Restaurant deleted successfully'
			expect(current_path).to eq '/restaurants'
	  end

	end
end
