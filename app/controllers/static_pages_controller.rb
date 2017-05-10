class StaticPagesController < ApplicationController
    before_action :logged_in_admin, only: [:index, :update, :destroy]
    
    def home
        @static = StaticPage.where("LOWER(title) = ?", "home")
        @static_pages = @static[0]
        @images = Image.select("filename").where("LOWER(gallery) = ?", "home")
        @img = []
        @images.each do |i|
            @img.push(i[:filename])
        end
        
    end
    
    def index
        @static_pages = StaticPage.all
        @pages = Page.all
    end
    
    # use only on creation of database -- ADD CREATE in :create
    def new
        @static_page = StaticPage.new    
    end

    def create
        @static_page = StaticPage.new(static_page_params)
        @static_page.gallery = @static_page.title
        if @static_page.save
            redirect_to root_path
        else
            flash[:error] = 'Failed to edit page!'
            render 'new'
        end
    end
    # //
    
    def edit
        @static_page = StaticPage.find params[:id]
    end
    
    def update
        @static_page = StaticPage.find params[:id]
        @static_page.gallery = @static_page.title
        if @static_page.update_attributes(static_page_params)
            redirect_to root_path
        else
            flash[:error] = 'Failed to edit page!'
            render :edit
        end
    end

    private
        def static_page_params
            params.require(:static_page).permit(:title, :description)
        end
        
        def logged_in_admin
            unless website_admin?
                store_location
                flash[:danger] = "Please log in as website admin."
                redirect_to login_url
            end
        end
        
        def valid_page?
          File.exist?(Pathname.new(Rails.root + 
            "app/views/#{params[:title]}/index.html.erb"))
        end
end
