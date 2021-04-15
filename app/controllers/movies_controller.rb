class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new
  end

  def index

    @list_of_movies = Movie.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @list_of_movies
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
     @the_movie = Movie.find(params.fetch(:id))

    render template: "movies/show"
  end

  def create
    @the_movie = Movie.new
    @the_movie.title = params.fetch(:title)
    @the_movie.description = params.fetch(:description)

    if @the_movie.valid?
      @the_movie.save
      redirect_to(movie_url(@the_movie), { :notice => "Movie created successfully." })
    else
      render template: "/movies/new"
    end
  end

  def edit
    # No longer 3-step method: the_id = params.fetch(:id)

    @the_movie = Movie.find(params.fetch(:id))

    render template: "movies/edit.html.erb"
  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.title = params.fetch(:movie).fetch(:title)
    the_movie.description = params.fetch(:movie).fetch(:description)

    if the_movie.valid?
      the_movie.save
      redirect_to movies_url(the_movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(the_movie), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."} )
  end
end
