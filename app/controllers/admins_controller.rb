class AdminsController < ApplicationController
    before_action :logged_in_admin, only: [:index, :edit, :update, :destroy]
    before_action :correct_admin, only: [:edit, :update]
    
    def show
        @admin = Admin.find params[:id]
    end
    
    def new
        @admin = Admin.new
    end
    
    def create
        @admin = Admin.new(admin_params)
        if @admin.save
            print "HERE AFTER SAVE"
            log_in(@admin)
            redirect_to  root_path
        else
            print "HERE BEFORE RENDER NEW"
            render 'new'
        end
    end
    
    private
        def admin_params
            params.require(:admin).permit(:name, :password, :password_confirmation)
        end
    
        def logged_in_admin
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end
        
        def correct_admin
            @admin = Admin.find(params[:id])
            redirect_to(root_url) unless @admin == current_admin
        end
        
end