class PagesController < ApplicationController
    before_action :logged_in_admin, only: [:create, :update, :destroy]
    
    def index
        redirect_to new_page_path
    end
    
    def show
    @page = Page.where("id = ?",  params[:id])
    if @page
        @page = @page[0]
        print @page
        @images = Image.select("filename").where("LOWER(gallery) = ?", @page[:gallery])
        @img = []
        @images.each do |i|
            @img.push(i[:filename])
        end
    end
   #     render 'shared/404', :status => 404 if @page.nil?
    end
    
    
    def new
        @page = Page.new    
    end

    def create
        @page = Page.new(page_params)
        @page.gallery = @page.title
        if @page.save
            redirect_to root_path
        else
            flash[:error] = 'Failed to edit page!'
            render 'new'
        end
    end
    
    def edit
        @page = Page.find params[:id]
    end
    
    def update
        @page = Page.find params[:id]
        @page.gallery = @page.title
        if @page.update_attributes(page_params)
            redirect_to pages_path
        else
            flash[:error] = 'Failed to edit page!'
            render :edit
        end
    end
    
    def destroy
        @page = Page.find params[:id]
        if @page.delete
            flash[:notice] = 'page deleted!'
            redirect_to pages_path
        else
            flash[:error] = 'Failed to delete page!'
            render :destroy
        end
    end

    private
        def page_params
            params.require(:page).permit(:title, :description, :content)
        end
        
        def logged_in_admin
            unless website_admin?
                store_location
                flash[:danger] = "Please log in as website admin."
                redirect_to login_url
            end
        end
end
