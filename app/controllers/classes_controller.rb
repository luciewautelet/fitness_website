class ClassesController < ApplicationController
    before_action :logged_in_admin, only: [:edit, :update, :destroy]
    before_action :logged_in_instructor, only: [:create]
    
    def assign
    end
    
    def index
        @cl = StaticPage.where("LOWER(title) = ?", "classes")
        @page = @cl[0]
        if @pages
            @images = Image.select("filename").where("LOWER(gallery) = ?", "classes")
            @img = []
            @images.each do |i|
                @img.push(i[:filename])
            end
        end

        if (params[:date])
            @today = Date.strptime(params[:date], "%Y-%m-%d")
        else
            @today = Date.today
        end
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
        
        
        i = 1
        set = false
        @days.each do |da|
            if da[0] == @today.strftime("%A").downcase
                da[1] = @today.strftime("%d")
                da[2] = @today.strftime("%m")
                set = true
            elsif set === false
                da[1] = ""
                da[2] = ""
            else
                da[1] = (@today + i).strftime("%d")
                da[2] = (@today + i).strftime("%m")
                i += 1
            end
        end
        @next = @today + i
        
        empty = true;
        @class_by_day = []
        @classes = Classe.all
        @classes = @classes.sort_by { |cl| [cl.date.to_time.strftime("%p"),cl.date.to_time.strftime("%l").to_i]}
        i = 0
        @days.each do |da|
            @class_by_day[i] = []
           @days[i][3] = 0
            @classes.each do |cl|
                if da[0] == cl.date.to_time.strftime("%A").downcase && da[1] == cl.date.to_time.strftime("%d") && da[2] == cl.date.to_time.strftime("%m")
                    @days[i][3] += 1
                    empty = false;
                end
            end
            i += 1
        end
    end
    
    def show
        @classe = Classe.find params[:id]
        @instructor = Admin.find @classe.instructor_id 
        @bookings = Booking.find_by_classe_type(@classe.ctype)
    end
    
    def new
        @classe = Classe.new
    end
    
    def newSetC
        if !params.has_key?(:id)
            redirect_to classes_path and return
        end
        
        @set_classes = []
        5.times do
          @set_classes << Classe.new
        end

        @first_classe = Classe.find(params["id"])
    end
    
    def createSetC
        @first_classe = Classe.find(params[:id])
        params[:classes].each do |d|
            @classe = Classe.new()
            @classe.date = Time.new(d['date(1i)'], d['date(2i)'], d['date(3i)'],
                                d['date(4i)'], d['date(5i)'])
            @classe.ctype = @first_classe.ctype
            @classe.description = @first_classe.description
            @classe.start = false
            @classe.first_classeId = @first_classe.id
            @classe.instructor_id = current_admin.id
            if !@classe.save
                flash[:error] = 'Failed to create classe!'
                render 'newSetC'
            end
        end
        redirect_to classes_path and return
    end
    
    def create
        @classe = Classe.new(classe_params)
        @classe.instructor_id = current_admin.id
        @classe.first_classeId = -1
        if @classe.save
            if @classe.start == true
                @classe.update_attributes(:first_classeId => @classe.id)
                redirect_to new_set_classes_path(id: @classe.id) and return
            else
                redirect_to  classes_path
            end
        else
            flash[:error] = 'Failed to create classe!'
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
        if @classe.first_classeId != -1
            @classes = Classe.where "first_classeId = ?", @classe.first_classeId
            @classes.each do |c|
                @classe.first_classeId = -1
            end
        end
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
        end
        
        def logged_in_admin
            unless website_admin?
                store_location
                flash[:danger] = "Please log in as website admin."
                redirect_to login_url
            end
        end
        
        def logged_in_instructor
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url
            end
        end
end
