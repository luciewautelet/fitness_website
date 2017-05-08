class StaticPagesController < ApplicationController
    before_action :logged_in_admin
    
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
        redirect_to new_static_page_path
    end
    
    def show
      if valid_page?
        redirect_to "#{params[:title]}/index.html.erb"
      else
        render file: "public/404.html", status: :not_found
      end
    end
    
    # TODO supprimer après avoir mis en DB !
    def new
        @static_page = StaticPage.new    
    end

    def create
        @static_page = StaticPage.new(static_page_params)
        @static_page.gallery = @static_page.title
        print("_____")
        print(@static_page.title)
        print(@static_page.gallery)
        print(@static_page.description)
        print("_____")
        if @static_page.save
            # render template: "#{params[:title]}/index.html.erb"
            redirect_to root_path
        else
            flash[:error] = 'Failed to edit page!'
            render 'new'
        end
    end
    # !!!!! FIN TODO
    
    def edit
        @static_page = page.find params[:id]
    end
    
    def update
        @static_page = page.find params[:id]
        @static_page.gallery = @static_page.title
        if @static_page.update_attributes(static_page_params)
            render template: "#{params[:title]}/index.html.erb"
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
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end
        def valid_page?
          File.exist?(Pathname.new(Rails.root + 
            "app/views/#{params[:title]}/index.html.erb"))
        end
end
