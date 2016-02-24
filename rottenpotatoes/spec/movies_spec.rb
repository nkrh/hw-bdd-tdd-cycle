require 'spec_helper'
require 'rails_helper'
 
describe Movie, :type => :model do
  describe 'listing movies that has same director to current movie' do
    fixtures :movies 
    it 'should return movies with same director' do
       current = movies(:one)
       similar_movies = current.search_directors
       similar_movies.each do |movie|
        expect(movie.director).to eq(current.director)
       end
    end
    it 'should not return movies if current movie does not have director' do
       current = movies(:three)
       similar_movies = current.search_directors
       expect(similar_movies).to be_nil
    end
  end
  describe 'movies ratings' do
     it 'should returns all MPAA ratings' do
        expect(Movie.all_ratings).to eq %w(G PG PG-13 NC-17 R)
     end
  end
end