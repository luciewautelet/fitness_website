class MembersController < ApplicationController
def index
        @member = Member.all
    end
    
    def show
        @member = Member.find params[:id]
    end
    
    def create
        @member = Member.new(member_params)
        if @member.save
            redirect_to  root_path
        else
            flash[:error] = 'Failed to edit member!'
            render 'new'
        end
    end
    
    def edit
        @member = Member.find params[:id]
    end
    
    def update
        @member = Member.find params[:id]
        if @member.update_attributes(member_params)
            redirect_to  root_path
        else
            flash[:error] = 'Failed to edit member!'
            render :edit
        end
    end
    
    def destroy
        @member = Member.find params[:id]
        if @member.delete
            flash[:notice] = 'Member deleted!'
            redirect_to root_path
        else
            flash[:error] = 'Failed to delete member!'
            render :destroy
        end
    end
    
    private
        def member_params
            params.require(:member).permit(:name, :phone, :email, :membership_no)
        end
end
