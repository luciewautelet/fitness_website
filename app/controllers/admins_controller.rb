class AdminsController < ApplicationController
    before_action :website_admin, only: [:index, :destroy]
    before_action :logged_in_admin, only: [:edit, :update]
    before_action :correct_admin, only: [:edit, :update]
    
    def index
        @admins = Admin.all
    end
    
    def show
        @admin = Admin.find params[:id]
    end
    
    def new
        @admin = Admin.new
    end
    
    def create
        @admin = Admin.new(admin_params)
        if @admin.admin_all == nil
            @admin.admin_all = false
        end
        if @admin.save
            log_in(@admin)
            redirect_to root_path
        else
            render 'new'
        end
    end
    
    def destroy
        @admin = Admin.find params[:id]
        if @admin.delete
            flash[:notice] = 'Admin deleted!'
            redirect_to admins_path
        else
            flash[:error] = 'Failed to delete admin!'
            render :destroy
        end
    end
    
    private
        def admin_params
            params.require(:admin).permit(:name, :password, :password_confirmation,
                                            :admin_all)
        end
    
        def logged_in_admin
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end
    
        def website_admin
            unless website_admin?
                store_location
                flash[:danger] = "Please log in as website admin."
                redirect_to login_url
            end
        end
        
        def correct_admin
            @admin = Admin.find(params[:id])
            redirect_to(root_url) unless @admin == current_admin
        end
        
end