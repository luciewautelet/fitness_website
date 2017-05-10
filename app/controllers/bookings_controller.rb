class BookingsController < ApplicationController
    before_action :logged_in_admin, only: [:index, :edit, :update, :destroy]
    
    def index
        @bookings = Booking.all
        @cl = StaticPage.where("LOWER(title) = ?", "bookings")
        @page = @cl[0]
        if @page
            @images = Image.select("filename").where("LOWER(gallery) = ?", "bookings")
            @img = []
            @images.each do |i|
                @img.push(i[:filename])
            end
        end
    end
    
    def show
        @booking = Booking.find params[:id]
    end
    
    def new
        @classe = Classe.find(params["format"])
        @booking = Booking.new
    end
    
    def create
        @classe = Classe.find(params["id"])
        if @classe.first_classeId != -1
            @classes = Classe.where "first_classeId = ?", @classe.first_classeId
            @classes.each do |c|
                @booking = Booking.new(booking_params)
                @booking.classe_type = c.ctype
                @booking.cdate = c.date
                if !@booking.save
                    flash[:error] = 'Failed to edit booking!'
                    render 'new'
                end
            end
            redirect_to classes_path
        else
            @booking = Booking.new(booking_params)
            @booking.classe_type = @classe.ctype
            @booking.cdate = @classe.date
            
            if @booking.save
                redirect_to classes_path
            else
                flash[:error] = 'Failed to edit booking!'
                render 'new'
            end
        end
    end
    
    def edit
        @booking = Booking.find params[:id]
    end
    
    def update
        @booking = Booking.find params[:id]
        if @booking.update_attributes(booking_params)
            redirect_to bookings_path
        else
            flash[:error] = 'Failed to edit booking!'
            render :edit
        end
    end
    
    def destroy
        @booking = Booking.find params[:id]
        if @booking.delete
            flash[:notice] = 'Booking deleted!'
            redirect_to bookings_path
        else
            flash[:error] = 'Failed to delete booking!'
            render :destroy
        end
    end
    
    private
        def booking_params
            if params[:booking][:member] == 0
                params[:booking][:membership_id] = -1
            end
            params.require(:booking).permit(:name, :phone, :email, :member, :membership_id)
        end
        
        def logged_in_admin
            unless website_admin?
                store_location
                flash[:danger] = "Please log in as website admin."
                redirect_to login_url
            end
        end
end
