class SingersController < ApplicationController
  before_action :set_singer, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  @column = "last_name"
  @direction = "asc"

  # GET /singers
  # GET /singers.json
  def index
    #@singers = Singer.all
    authorize Singer
    @q = Singer.search(params[:q])
    @singers = @q.result(distinct: true)
    @singers = @singers.order("#{sort_column} #{sort_direction}")
  end

  # GET /singers/1
  # GET /singers/1.json
  def show
    authorize Singer
  end

  # GET /singers/new
  def new
    @singer = Singer.new
    authorize @singer
  end

  # GET /singers/1/edit
  def edit
    skip_authorization
    @singers = policy_scope(Singer)

  end

  # POST /singers
  # POST /singers.json
  def create
    @singer = Singer.new(singer_params)
    authorize @singer

    respond_to do |format|
      if @singer.save
        format.html { redirect_to @singer, notice: 'Singer was successfully created.' }
        format.json { render :show, status: :created, location: @singer }
      else
        format.html { render :new }
        format.json { render json: @singer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /singers/1
  # PATCH/PUT /singers/1.json
  def update
    #authorize @singer
    skip_authorization
    respond_to do |format|
      if @singer.update(singer_params)
        format.html { redirect_to @singer, notice: 'Singer was successfully updated.' }
        format.json { render :show, status: :ok, location: @singer }
      else
        format.html { render :edit }
        format.json { render json: @singer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /singers/1
  # DELETE /singers/1.json
  def destroy
    authorize @singer
    @singer.destroy
    respond_to do |format|
      format.html { redirect_to singers_url, notice: 'Singer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_singer
      @singer = Singer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def singer_params
      params.require(:singer).permit( :image, :image_data, :remove_image, :last_name, :first_name, :email, :voice, :joined, :left, :join_year, :left_year, :notes, {:concert_ids => []}, {:song_ids => []})
    end

    def sortable_columns
      [ "last_name", "first_name","email", "voice"]
    end

    def sort_column
      #puts "CH  #{@column} #{@direction}"
      sortable_columns.include?(params[:column]) ? params[:column] : "last_name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
