class PicturesController < ApplicationController
  before_action :set_singer, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  @column = "caption"
  @direction = "asc"

  # GET /pictures
  # GET /pictures.json
  def index
    #@singers = Singer.all
    authorize Picture
    @q = Picture.search(params[:q])
    @pictures = @q.result(distinct: true)
    @pictures = @pictures.order("#{sort_column} #{sort_direction}")
  end

  # GET /pictures/1
  # GET /picturess/1.json
  def show
    authorize Picture
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
    authorize @picture
  end

  # GET /pictures/1/edit
  def edit
    skip_authorization
    @pictures = policy_scope(Picture)

  end

  # POST /singers
  # POST /singers.json
  def create
    @picture = Picture.new(picture_params)
    authorize @picture

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    authorize @picture
    skip_authorization
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    authorize @picture
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Singer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_singer
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit( :picture, :remove_picture, :caption, :picture_date, :notes, :submitted_by )
    end

    def sortable_columns
      [ "caption", "picture_date", "submitted_by"]
    end

    def sort_column
      #puts "CH  #{@column} #{@direction}"
      sortable_columns.include?(params[:column]) ? params[:column] : "caption"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
