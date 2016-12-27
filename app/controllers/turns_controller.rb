class TurnsController < ApplicationController
  before_action :set_turn, only: [:show, :edit, :update, :destroy]

  # GET /turns
  # GET /turns.json
  def index
    @turns = Turn.where(user_id: (current_user)).all
  end

  # GET /turns/1
  # GET /turns/1.json
  def show
  end

  # GET /turns/newparams[:cancha].nil?params[:cancha].nil?params[:cancha].nil?params[:cancha].nil?
  def new
    p params[:cancha].nil?
    if !(params[:cancha].nil?)
      @turns = Turn.where(cancha_id: (params[:cancha])).all
    else
      @turns = []
    end
    @turn = Turn.new

  end

  # GET /turns/1/edit
  def edit
  end

  # POST /turns
  # POST /turns.json
  def create #los turnos siempre se crean de a 1hora
    if current_user.canBuy
      current_user.remove_credit(1)
      date = Time.at(params[:start].to_i / 1000)
      turns_params={ :date => date,
        :cancha_id => params[:cancha],
        :user_id => current_user.id}
        @turn = Turn.new(turns_params)
        respond_to do |format|
          if @turn.save
            format.html { redirect_to turns_path, notice: 'Turn was successfully created.' }
            format.json { render :show, status: :created, location: @turn }
          else
            format.html { render :new }
            format.json { render json: @turn.errors, status: :unprocessable_entity }
          end
        end
      else
        flash[:notice] = "No tiene creditos para reservar el turno"
        redirect_to action: "new"
      end
    end

    # PATCH/PUT /turns/1
    # PATCH/PUT /turns/1.json
    def update
    end

    # DELETE /turns/1
    # DELETE /turns/1.json
    def destroy
      day=@turn.date
      today=DateTime.now
      if  (day > today)
        @turn.destroy
        current_user.create_credit(1)
        respond_to do |format|
          format.html { redirect_to turns_url, notice: 'El turno se Canceló correctamente' }
          format.json { head :no_content }
        end
      else
        flash[:notice] = "No se puede cancelar turnos con menos de 3hs de anticipacion"
        redirect_to action: "index"
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn
      @turn = Turn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def turn_params
      params.require(:turn).permit(:date, :user_id, :cancha_id)
    end
  end
