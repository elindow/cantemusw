class ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  #current_or_guest_user

  # GET /concerts
  # GET /concerts.json
  def index

    current_or_guest_user
    authorize Concert
    #@concerts = Concert.all
    @q = Concert.search(params[:q])
    @concerts = @q.result(distinct: true)
    @concerts = @concerts.order("#{sort_column} #{sort_direction}")
  end

  # GET /concerts/1
  # GET /concerts/1.json
  def show
    authorize Concert
  end

  # GET /concerts/new
  def new
    @concert = Concert.new
    authorize @concert
  end

  # GET /concerts/1/edit
  def edit
    authorize Concert
  end

  # POST /concerts
  # POST /concerts.json
  def create
    @concert = Concert.new(concert_params)
    authorize @concert

    respond_to do |format|
      if @concert.save
        format.html { redirect_to @concert, notice: 'Concert was successfully created.' }
        format.json { render :show, status: :created, location: @concert }
      else
        format.html { render :new }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /concerts/1
  # PATCH/PUT /concerts/1.json
  def update
    authorize @concert
    respond_to do |format|
      if @concert.update(concert_params)
        format.html { redirect_to @concert, notice: 'Concert was successfully updated.' }
        format.json { render :show, status: :ok, location: @concert }
      else
        format.html { render :edit }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /concerts/1
  # DELETE /concerts/1.json
  def destroy
    authorize @concert
    @concert.destroy
    respond_to do |format|
      format.html { redirect_to concerts_url, notice: 'Concert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concert
      @concert = Concert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concert_params
      params.require(:concert).permit(:name, :venue, :concertdate, :conductor, :accompanist, :theme, :notes, :concert_year, {:singer_ids => []}, {:song_ids => []}, :sort)
    end

    def sortable_columns
      ["concert_year", "name", "venue", "concertdate"]
    end

    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : "concert_year"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end
