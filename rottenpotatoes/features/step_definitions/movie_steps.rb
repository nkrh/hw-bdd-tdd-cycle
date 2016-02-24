# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.//table[@id="movies"]/tbody/tr/td[text()="Chicken Run"]
  e1i, e2i, i = 0, 0, 1
  page.all('table#movies tbody tr').each do |tr|
    text = tr.all('td')[0].text
    if text == e1
      e1i = i
    elsif text == e2
      e2i = i
    end
    i += 1
  end
  yes = !(e1i + e2i).zero? and e1i < e2i
  expect(yes).to be true
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list = rating_list.split(', ')
  if uncheck
    rating_list.each do |rating|
      uncheck "ratings[#{rating}]"
    end
  else
    rating_list.each do |rating|
     check "ratings[#{rating}]"
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  expect(page.all('table#movies tbody tr').count).to eq(Movie.count)
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  expect(page).to have_content(title)
  expect(page).to have_content(director)
end