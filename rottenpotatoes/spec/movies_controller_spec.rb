require 'spec_helper'
require 'rails_helper'

describe MoviesController, :type => :controller do
  describe 'creating a movie' do
    it 'should have a create page' do
      get :new
      expect(response).to render_template('new')
    end
    it 'should add a movie' do 
      before = Movie.count
      post :create, {
        movie: {
          title: 'test', 
          rating: 'R', 
          description: 'test', 
          release_date: '2011-11-11', 
          director: 'test'
          }
      }
      expect(Movie.count).to eq(before + 1)
    end
  end
  describe 'deleting a movie' do
    it 'should remove movie' do
      movie = instance_double('Movie', {
          title: 'Test movie',
          destroy: true
      })
      allow(Movie).to receive(:find).with('1').and_return(movie)
      expect(movie).to receive(:destroy)
      delete :destroy, id: 1
    end
  end
  describe 'updating a movie' do
    it 'should have a edit page' do
      expect(Movie).to receive(:find)
      get :edit, id: 1
    end
    it 'should update a movie' do
      movie = instance_double('Movie', {
        update_attributes!: true,
        title: 'test'
      })
      update_params = {
        title: 'TEST', 
        rating: 'R', 
        description: 'TEST', 
        release_date: '2011-11-11', 
        director: 'TEST'  
      }
      allow(Movie).to receive(:find).with('1').and_return(movie)
      expect(movie).to receive(:update_attributes!).with(update_params)
      put :update, id: 1, movie: update_params
    end
  end
  describe 'showing movies' do
    it 'should be sorted and filtered' do
      movies = double('movies', {order: nil})
      allow(Movie).to receive(:where).and_return(movies)
      expect(movies).to receive(:order)
      get :index
    end
    it 'should able to show indivdual movie' do
      movie = instance_double('Movie')
      allow(Movie).to receive(:find).with('1').and_return(movie)
      get :show, id: 1
      expect(response).to render_template('show') 
    end
    it 'should have restful url' do
      movies = double('movies', {order: nil})
      allow(Movie).to receive(:where).and_return(movies)
      get :index, ratings: {PG: 1}
      expect(response).to redirect_to movies_path ratings: {PG: 1}
    end
  end
  describe 'listing similar movies that has same director to current movie' do
    it 'should redirect to home if current movie has no director info' do
        movie = instance_double('Movie', {
            director: '', 
            search_directors: nil, 
            title: 'Test movie'
        })
        allow(Movie).to receive(:find).with('1').and_return(movie)
        get :search_directors, {id: 1}
        expect(assigns(:movies)).to be_nil
        expect(response).to redirect_to(movies_path)
    end
    it 'should lists similar movies if any' do
        similar_movie = instance_double('Movie', {
            director: 'Test', 
            title: 'Test movie 2'
        })
        
        movie = instance_double('Movie', {
            director: 'Test', 
            search_directors: [similar_movie], 
            title: 'Test movie'
        })
        allow(Movie).to receive(:find).with('1').and_return(movie)
        get :search_directors, {id: 1}
        expect(assigns(:movies)).to eq([similar_movie])
        expect(response).to render_template('search_directors') 
    end
  end
end
