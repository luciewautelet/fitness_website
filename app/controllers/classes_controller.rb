class ClassesController < ApplicationController
    def index
        @days = []
        @days[0] = []
        @days[0][0] = "monday"
        @days[1] = []
        @days[1][0] = "tuesday"
        @days[2] = []
        @days[2][0] = "wednesday"
        @days[3] = []
        @days[3][0] = "thursday"
        @days[4] = []
        @days[4][0] = "friday"
        @days[5] = []
        @days[5][0] = "saturday";
        @days[6] = []
        @days[6][0] = "sunday";
        @class_by_day = []
        @classes = Classe.all
    @classes = @classes.sort_by { |cl| cl.date.to_time.strftime("%l").to_i}
        i = 0
        @days.each do |da|
            @class_by_day[i] = []
           @days[i][1] = 0
            @classes.each do |cl|
                if da[0] == cl.date.to_time.strftime("%A").downcase
                    @days[i][1] += 1
                end
            end
            i += 1
        end
        
    end
    
    def show
        @classe = Classe.find params[:id]
        @instructor = Admin.find_by(@classe.instructor_id)
        @bookings = Booking.find_by_classe_type(@classe.ctype)
    end
    
    def new
        @classe = Classe.new
    end
    
    def create
        @classe = Classe.new(classe_params)
        @classe.instructor_id = current_admin.id
        if @classe.save
            redirect_to  classes_path
        else
            flash[:error] = 'Failed to edit classe!'
            render 'new'
        end
    end
    
    def edit
        @classe = Classe.find params[:id]
    end
    
    def update
        @classe = Classe.find params[:id]
        if @classe.update_attributes(classe_params)
            redirect_to  classes_path
        else
            flash[:error] = 'Failed to edit classe!'
            render :edit
        end
    end
    
    def destroy
        @classe = Classe.find params[:id]
        if @classe.delete
            flash[:notice] = 'Classe deleted!'
            redirect_to classes_path
        else
            flash[:error] = 'Failed to delete classe!'
            render :destroy
        end
    end
    
    private
        def classe_params
            params.require(:classe).permit(:ctype, :start, :date, :description,
                                    :instructor_id)
                                    #, "date(1i)", "date(2i)",
                                    # "date(3i)", "date(4i)", "date(5i)"
        end
end
