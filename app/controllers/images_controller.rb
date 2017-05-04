class ImagesController < ApplicationController
    def index
        @image = Image.all
    end
    
    def show
        @image = Image.find params[:id]
    end
    
    def create
        @image = Image.new(image_params)
        if @image.save
            redirect_to  root_path
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
            redirect_to  root_path
        else
            flash[:error] = 'Failed to edit image!'
            render :edit
        end
    end
    
    def destroy
        @image = Image.find params[:id]
        if @image.delete
            flash[:notice] = 'Image deleted!'
            redirect_to root_path
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
end
