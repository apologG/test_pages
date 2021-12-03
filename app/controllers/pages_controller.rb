class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update]

  def index
    @pages = Page.all
  end

  def show
  end

  def new
    @page = Page.new(parent_id: params[:parent_id])
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to subpage_path(@page)
    else
      flash[:error] = "Contact failed to be created."
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to subpage_path(@page)
    else
      render :edit
    end
  end

  private

  def set_page
    p params[:path]
    @page = Page.friendly.find(params[:slug])
  end

  def page_params
    params.require(:page).permit(:name, :title, :content, :parent_id)
  end

end
