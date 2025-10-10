class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy increment_chapter ]
  before_action :set_list, only: %i[ show new create edit update destroy increment_chapter ]
  before_action :authorize_list_access, only: %i[ show edit update destroy ] # Same as in ListsController to ensure users can only access their own lists


  # GET /books or /books.json
  """
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show
  end

  """

  # GET /books/new
  def new
    if authorize_list_access == false
      return
    else
      @book = @list.books.build(chaptersRead: 0, volumesRead: 0)
    end
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = @list.books.build(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book.list, notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @list, notice: "\"#{@book.title}\" was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def increment_chapter
    @book.increment!(:chaptersRead)

    respond_to do |format|
      format.html { redirect_to @list, notice: "Chapter count for #{@book.title} incremented to #{@book.chaptersRead}." }
      format.json { render json: { chaptersRead: @book.chaptersRead } }
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to @list, notice: "Book was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def set_list
      if params[:list_id]
        @list = List.find(params[:list_id])
      elsif @book&.list
        @list = @book.list
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to lists_path, alert: "List not found."
    end

    # Same mechanism as in ListsController to ensure users can only access their own lists
    def authorize_list_access
      unless @list.user == current_user
        redirect_to lists_path, alert: "You are not authorized to access this list."
      end
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :image, :chaptersRead, :volumesRead, :dateStarted, :dateCompleted, :status)
    end
end
