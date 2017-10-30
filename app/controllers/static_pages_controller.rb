class StaticPagesController < ApplicationController
  before_action :authorize_admin, except: :show

  def index
    @static_pages = StaticPage.all
  end

  def show
    page = StaticPage.find_by_slug(params[:slug])

    render_not_found if page.nil?

    @content = if page.markdown?
                 Kramdown::Document.new(page.content).to_html
               else
                 page.content
               end
  end

  def new
    @static_page = StaticPage.new
  end

  def edit
    @static_page = StaticPage.find(params[:id])
  end

  def create
    @static_page = StaticPage.new(static_page_params)

    if @static_page.save
      redirect_to static_pages_path
    else
      render :new
    end
  end

  def update
    @static_page = StaticPage.find(params[:id])

    if @static_page.update(static_page_params)
      redirect_to static_pages_path
    else
      render :edit
    end
  end

  def destroy
    @static_page = StaticPage.find(params[:id])

    @static_page.destroy

    redirect_to static_pages_url
  end

  private

  def static_page_params
    params.require(:static_page).permit(:slug, :content, :markup_type)
  end
end
