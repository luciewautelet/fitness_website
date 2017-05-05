class ImagesController < ApplicationController
    before_action :logged_in_admin
    
    def index
        @images = Image.all
    end
    
    def show
        @image = Image.find params[:id]
    end
    
    def new
        @image = Image.new
    end
    
    def create
        @image = Image.new(image_params)
        if @image.save
            redirect_to images_path
        else
            flash[:error] = 'Failed to edit image!'
            render 'new'
        end
    end
    
    def edit
        @image = Image.find params[:id]
    end
    
    def update
        @image = Image.find params[:id]
        if @image.update_attributes(image_params)
            redirect_to images_path
        else
            flash[:error] = 'Failed to edit image!'
            render :edit
        end
    end
    
    def destroy
        @image = Image.find params[:id]
        if @image.delete
            flash[:notice] = 'Image deleted!'
            redirect_to images_path
        else
            flash[:error] = 'Failed to delete image!'
            render :destroy
        end
    end
    
    private
        def image_params
            params.require(:image).permit(:gallery, :filename, :alt_text,
                                            :caption)
        end
        
        def logged_in_admin
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end
end
