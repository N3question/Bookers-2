class  BooksController  < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save # !でエラーメッセージの表示が可能
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book.id) 
      # 今回の引数は必ず中身が入っている必要がある。例外もあり。
      # linkを自動的にクリックするイメージ
    else
      @books = Book.all # 追加 renderは前の情報が引き継げないため情報をわたす
      render :index # html.erb > 別のViewファイルを開くイメージ
    end
  end
  
  def show
    @new_book = Book.new # インスタンス変数は好きに設定できる
    @book = Book.find(params[:id]) 
  end
  
  def index
    @book = Book.new
    @books = Book.all
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated Book successfully."
      redirect_to book_path(@book.id)
    else
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
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless current_user == book.user # 反対でもOK
      redirect_to books_path
    end
  end
  
end