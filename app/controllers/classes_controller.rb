class ClassesController < ApplicationController
    def index
        @classes = Classe.all
    end
    
    def show
        @classe = Classe.find params[:id]
        @instructor = Admin.find_by(@classe.instructor_id)
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
