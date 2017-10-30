class WordsController < ApplicationController
  before_action :set_model, only: [:destroy, :update, :show, :edit]
  before_action :authorize_admin

  def index
    @words = Word.preload(:user).all
  end

  def show
  end

  def new
    @word = Word.new
  end

  def edit
  end

  def create
    @word = Word.new(word_params)

    @word.user = current_user

    if @word.save
      redirect_to @word
    else
      render :new
    end
  end

  def update
    if @word.update(word_params)
      redirect_to @word
    else
      render :edit
    end
  end

  def destroy
    @word.destroy

    redirect_to words_url
  end

  def set_model
    @word = Word.find(params[:id])
  end

  private

  def word_params
    params.require(:word).permit(:text, :creator_id)
  end
end
