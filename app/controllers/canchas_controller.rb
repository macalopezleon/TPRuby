class CanchasController < ApplicationController
  before_action :set_cancha, only: [:show, :edit, :update, :destroy]

  # GET /canchas
  # GET /canchas.json
  def index
    @canchas = Cancha.all
  end

  # GET /canchas/1
  # GET /canchas/1.json
  def show
  end

  # GET /canchas/new
  def new
    @cancha = Cancha.new
  end

  # GET /canchas/1/edit
  def edit
  end

  # POST /canchas
  # POST /canchas.json
  def create
    @cancha = Cancha.new(cancha_params)

    respond_to do |format|
      if @cancha.save
        format.html { redirect_to @cancha, notice: 'Cancha was successfully created.' }
        format.json { render :show, status: :created, location: @cancha }
      else
        format.html { render :new }
        format.json { render json: @cancha.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /canchas/1
  # PATCH/PUT /canchas/1.json
  def update
    respond_to do |format|
      if @cancha.update(cancha_params)
        format.html { redirect_to @cancha, notice: 'Cancha was successfully updated.' }
        format.json { render :show, status: :ok, location: @cancha }
      else
        format.html { render :edit }
        format.json { render json: @cancha.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /canchas/1
  # DELETE /canchas/1.json
  def destroy
    @cancha.destroy
    respond_to do |format|
      format.html { redirect_to canchas_url, notice: 'Cancha was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cancha
      @cancha = Cancha.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cancha_params
      params.require(:cancha).permit(:name, :size, :price, :user_id, :cancha_id)
    end
end
