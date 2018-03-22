class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    @authorship = Authorship.new()

    @authorships = Authorship.where(author_id: "#{@author.id}").includes(:book)
    authored_books = @authorships.map { |i| i.book.id }
    @books = Book.all_except(authored_books).order(:title)
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  # POST /authors.json
  def create
    @book = Book.find(params[:book_id])
    author = Author.where(author_params)

    if author.exists?
      @book.authorships.new(author_id: author[0][:id])
    else
      @book.authors.new(author_params)
    end

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { redirect_to @book, notice: 'There was an error creating the author.' }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_book
    @author = Author.find(params[:author_id])
    @author.remove_book(params)
    respond_to do |format|
      format.html { redirect_to @author, notice: 'Book was removed successfully.' }
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:first_name, :last_name, :age)
    end
end
