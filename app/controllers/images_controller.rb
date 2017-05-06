class ImagesController < ApplicationController
    before_action :logged_in_admin
    
    def index
        @images = image.all
    end
    
    def show
        @image = image.find params[:id]
    end
    
    def new
        @image = image.new
    end
    
    def create
        @image = image.new(image_params)
        if @image.save
            redirect_to images_path
        else
            flash[:error] = 'Failed to edit image!'
            render 'new'
        end
    end
    
    def edit
        @image = image.find params[:id]
    end
    
    def update
        @image = image.find params[:id]
        if @image.update_attributes(image_params)
            redirect_to images_path
        else
            flash[:error] = 'Failed to edit image!'
            render :edit
        end
    end
    
    def destroy
        @image = image.find params[:id]
        if @image.delete
            flash[:notice] = 'image deleted!'
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
