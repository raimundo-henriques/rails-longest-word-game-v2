require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "You can fill the form with a random word, click the play button, and get a message that the word is not in the grid." do
    visit new_url
    fill_in 'word', with: '_,.a.,_'
    click_on 'Play'

    assert_text 'Sorry but _,.A.,_ can\'t be built out of'
  end

  test "You can fill the form with a one-letter consonant word, click play, and get a message that the word is not a valid English word." do
    visit new_url
    fill_in 'word', with: 'q'
    click_on 'Play'

    assert_text 'Sorry but Q does not seem to be a valid English word...'
  end

  test "You can fill the form with a valid English word, click play and get a “Congratulations” message." do
    visit new_url
    fill_in 'word', with: 'a'
    click_on 'Play'

    assert_text 'Congratulations! A is a valid English word!'
  end
end
