class  BooksController  < ApplicationController
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save! # !でエラーメッセージの表示が可能
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id) # 今回の引数は必ず中身が入っている必要がある。例外もあり。
    else
      render :new
    end
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def index
    @books = Book.all
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "You have updated Book successfully."
      redirect_to book_path(book.id)
    else
      flash[:alert] = "You have not updated Book successfully."
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id]) 
    book.destroy
    redirect_to books_path
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end