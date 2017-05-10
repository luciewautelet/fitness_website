class ImagesController < ApplicationController
    before_action :logged_in_admin
    
    def index
        @images = Image.all
    end
    
    def show
        @image = Image.find params[:id]
    end
    
    def new
        @list = StaticPage.all
        @list += Page.all
        @image = Image.new
    end
    
    def create
        
        @image = Image.new(image_params)
        
        uploaded_io = params[:image][:filename]
        File.open(Rails.root.join('public', 'images', 
                                uploaded_io.original_filename), 'wb') do |file|
                    file.write(uploaded_io.read)
        end
        
        @image.filename = uploaded_io.original_filename
        
        if @image.save
            redirect_to images_path
        else
            flash[:error] = 'Failed to edit image!'
            render 'new'
        end
    end
    
    def edit
        @list = StaticPage.all
        @list += Page.all
        @image = Image.find params[:id]
    end
    
    def update
        @list = StaticPage.all
        @list += Page.all
        @image = Image.find params[:id]
        if @image.update_attributes(upload_image_params)
            redirect_to images_path
        else
            flash[:error] = 'Failed to edit image!'
            render :edit
        end
    end
    
    def destroy
        @image = Image.find params[:id]
        if @image.delete
            flash[:notice] = 'image deleted!'
            redirect_to images_path
        else
            flash[:error] = 'Failed to delete image!'
            render :destroy
        end
    end
    
    private
        def upload_image_params
            params.require(:image).permit(:gallery, :alt_text, :caption)
        end
        def image_params
            params.require(:image).permit(:gallery, :filename, :alt_text,
                                            :caption)
        end
        
        def logged_in_admin
            unless website_admin?
                store_location
                flash[:danger] = "Please log in as website admin."
                redirect_to login_url
            end
        end
end
