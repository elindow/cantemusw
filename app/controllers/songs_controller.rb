class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /songs
  # GET /songs.json
  def index
    #@songs = Song.all
    authorize Song
    @q = Song.search(params[:q])
    @songs = @q.result(distinct: true)
    @songs = @songs.order("#{sort_column} #{sort_direction}")
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    authorize Song
  end

  # GET /songs/new
  def new
    @song = Song.new
    authorize @song
  end

  # GET /songs/1/edit
  def edit
    authorize @song
    @song.s_o = 0
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)
    authorize @song

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    authorize @song
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    authorize @song
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:name, :source, :composer, :lyricist, :arranger, :genre, :song_type, :notes, {:singer_ids => []}, {:concert_ids => []}, :s_o, programs_attributes: [ :song_order ] )
    end

    def sortable_columns
      ["name", "source", "composer","lyricist","arranger","genre","song_type"]
    end

    def sort_column
      sortable_columns.include?(params[:column]) ? params[:column] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
