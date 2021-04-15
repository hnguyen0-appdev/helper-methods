class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def index

    @movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html do
        render template: "movies/index"
      end
    end
  end

  def show
    
  # OlD WAY: matching_movies = Movie.where({ :id => the_id }).first
  # matching_movies = Movie.find_by({ :id => the_id })
  
  # NEW WAY:
     @movie = Movie.find(params.fetch(:id))

    render template: "movies/show"
  end

  def create

    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)
    

    if @movie.valid?
      @movie.save
      redirect_to(movie_url(@movie), { :notice => "Movie created successfully." })
    else
      render template: "/movies/new"
    end
  end

  def edit
    # No longer 3-step method: the_id = params.fetch(:id)
    
    @movie = Movie.find(params.fetch(:id))

    render template: "movies/edit.html.erb"
  end

  def update
    @movie = Movie.find(params.fetch(:id))

    if movie.valid?
      movie.save
      redirect_to movies_url(movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(movie), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    the_id = params.fetch(:id)
    movie = Movie.where({ :id => the_id }).first

    movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."} )
  end
end
