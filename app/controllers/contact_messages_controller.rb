class ContactMessagesController < ApplicationController
    before_action :logged_in_admin, only: [:edit, :update, :destroy]
    
    def index
        if !logged_in?
            redirect_to new_contact_message_path
        end
        @contact_messages = ContactMessage.all
        @cl = StaticPage.where("LOWER(title) = ?", "contact")
        @page = @cl[0]
        if @pages
            @images = Image.select("filename").where("LOWER(gallery) = ?", "contact")
            @img = []
            @images.each do |i|
                @img.push(i[:filename])
            end
        end
        
    end
    
    def show
        @contact_message = ContactMessage.find params[:id]
    end
    
    def new
        @cl = StaticPage.where("LOWER(title) = ?", "contact")
        @page = @cl[0]
        if @pages
            @images = Image.select("filename").where("LOWER(gallery) = ?", @page[:gallery])
            @img = []
            @images.each do |i|
                @img.push(i[:filename])
            end
        end
        
        @contact_message = ContactMessage.new
    end
    
    def create
        @contact_message = ContactMessage.new(contact_message_params)
        if @contact_message.save
            redirect_to  contact_messages_path
        else
            flash[:error] = 'Failed to edit contact_message!'
            render 'new'
        end
    end
    
    def destroy
        @contact_message = ContactMessage.find params[:id]
        if @contact_message.delete
            flash[:notice] = 'Contact_message deleted!'
            redirect_to contact_messages_path
        else
            flash[:error] = 'Failed to delete contact_message!'
            render :destroy
        end
    end
    
    private
        def contact_message_params
            params.require(:contact_message).permit(:name, :phone, :email,
                                                    :message_content)
        end
        
        def logged_in_admin
            unless website_admin?
                store_location
                flash[:danger] = "Please log in as website admin."
                redirect_to login_url
            end
        end
        
end
