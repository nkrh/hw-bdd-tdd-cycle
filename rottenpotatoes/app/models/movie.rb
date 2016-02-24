class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def search_directors
    if(!self.director.empty?)
      self.class.where(director: self.director)
    end
  end
end