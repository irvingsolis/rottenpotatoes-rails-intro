class MoviesController < ApplicationController
  #def movie_params
   # params.require(:movie).permit(:title, :rating, :description, :release_date)
  #end
  def index
    @all_ratings = ['G', 'PG', 'PG-13', 'R']

    if params[:ratings]
      @movies = Movie.where(rating: params[:ratings].keys)
   end
    #@movies = Movie.all   
      case params[:sort]
    when 'title'
      @movies = Movie.order('title ASC')
      @title_hilite = 'hilite'
    when 'release'
      @movies = Movie.order('release_date ASC')
      @release_hilite = 'hilite'
    else
      #@movies = Movie.all
      params[:ratings] ? @movies = Movie.where(rating: params[:ratings].keys) :
                         @movies = Movie.all
    end
  end
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
