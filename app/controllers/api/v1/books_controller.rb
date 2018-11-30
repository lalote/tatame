module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_author, only: [:show, :update, :destroy]
      before_action :set_book, only: [:show, :update, :destroy]
      before_action :set_books, only: [:index]

      # GET /books
      def index
        render json: @books
      end

      # GET /books/1
      def show
        render json: @book
      end

      # POST /books

      def create
        @book = @author.books.new(book_params)

        if @book.save
          render json: @book, status: :created, location: @book
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /books/1
      def update
        if @author.books.update(book_params)
          render json: @author.books
        else
          render json: @author.books.errors, status: :unprocessable_entity
        end
      end

      # DELETE /books/1
      def destroy
        @author.books.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.

        def set_author
          @author = Author.find(params[:author_id])

          #raise @author.inspect
        end

        def set_book
          #raise @author.books.find(params[:id]).inspect
          @book = @author.books.find(params[:id])
        end

        def set_books
          @books = Book.where(author_id: params[:author_id])
        end

        # Only allow a trusted parameter "white list" through.
        def book_params
          params.require(:book).permit(:id,:author_id, :title, :price)
        end
    end
  end
end
