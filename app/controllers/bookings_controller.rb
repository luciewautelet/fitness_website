class BookingsController < ApplicationController
    before_action :logged_in_admin, only: [:index, :edit, :update, :destroy]
    
    def index
        @bookings = Booking.all
    end
    
    def show
        @booking = Booking.find params[:id]
    end
    
    def new
        @booking = Booking.new
    end
    
    def create
        @booking = Booking.new(booking_params)
        if @booking.save
            redirect_to classes_path
        else
            flash[:error] = 'Failed to edit booking!'
            render 'new'
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
            print("------------------")
            print(params[:booking][:member])
            print(params[:booking][:membership_id])
            print("------------------")
            params.require(:booking).permit(:classe_type, :cdate, :name, :phone,
                    :email, :member, :membership_id)
        end
        
        def logged_in_admin
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end
end
