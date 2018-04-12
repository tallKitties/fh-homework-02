class AuthorshipsController < ApplicationController

  def create
    @authorship = Authorship.new(authorship_params)
    author = Author.find_by(id: authorship_params[:author_id])

    respond_to do |format|
      if @authorship.save
        format.html { redirect_to author, notice: 'Book was added successfully.'}
      else
        format.html { redirect_to author}
      end
    end
  end

  def destroy
    authorship = Authorship.find(params[:id])
    book = authorship.book
    author = authorship.author
    authorship.destroy

    respond_to do |format|
      format.html { redirect_to book,
        notice: "#{author.full_name} was successfully removed from #{authorship.book.title}." }
    end
  end

  private

  def authorship_params
    params.require(:authorship).permit(:book_id, :author_id)
  end
end
