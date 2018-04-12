class BooksController < ApplicationController
  before_action :set_book, only: [:destroy, :update]
  before_action :set_book_with_authors, only: [:show, :edit]

  # GET /books
  # GET /books.json
  def index
    @books = Book.search(params).includes(:authors)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @author = Author.new
  end

  def new_author
    book = Book.find(params[:book_id])
    author = Author.find_by(author_params)

    if author
      if book.authorships.find_by(author_id: author.id)
        redirect_to book, notice: "#{book.title} already has that author." and return
      else
        book.authorships.new(author_id: author.id)
      end
    else
      book.authors.new(author_params)
    end

    respond_to do |format|
      if book.save
        format.html { redirect_to book, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: book }
      else
        format.html { redirect_to book, notice: 'There was an error creating the author.' }
        format.json { render json: aauthor.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def set_book_with_authors
      @book = Book.includes(:authors).find(params[:id])
      @authors = @book.authors
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :sub_title, :publisher, :genre, :classification, :general_type, :year)
    end

    def author_params
      params.require(:author).permit(:first_name, :last_name, :age)
    end
end
