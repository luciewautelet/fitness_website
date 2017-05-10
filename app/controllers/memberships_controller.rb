class MembershipsController < ApplicationController
    before_action :logged_in_admin, except: [:index]
    
    def index
        @memberships = Membership.all
        @cl = StaticPage.where("LOWER(title) = ?", "memberships")
        @page = @cl[0]
            if @pages
            @images = Image.select("filename").where("LOWER(gallery) = ?", lowercase("memberships"))
            @img = []
            @images.each do |i|
                @img.push(i[:filename])
            end
        end
    end
    
    def show
        @membership = Membership.find params[:id]
    end
    
    def new
        @membership = Membership.new
    end
    
    def create
        @membership = Membership.new(membership_params)
        if @membership.save
            redirect_to  memberships_path
        else
            flash[:error] = 'Failed to edit membership!'
            render 'new'
        end
    end
    
    def edit
        @membership = Membership.find params[:id]
    end
    
    def update
        @membership = Membership.find params[:id]
        if @membership.update_attributes(membership_params)
            redirect_to memberships_path
        else
            flash[:error] = 'Failed to edit membership!'
            render :edit
        end
    end
    
    def destroy
        @membership = Membership.find params[:id]
        if @membership.delete
            flash[:notice] = 'Membership deleted!'
            redirect_to memberships_path
        else
            flash[:error] = 'Failed to delete membership!'
            render :destroy
        end
    end
    
    private
        def membership_params
            params.require(:membership).permit(:mtype, :price, :description)
        end
        
        def logged_in_admin
            unless website_admin?
                store_location
                flash[:danger] = "Please log in as website admin."
                redirect_to login_url
            end
        end
end
