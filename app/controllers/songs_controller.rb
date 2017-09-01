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
        #songs = Song.all
        #byebug
        #puts "got here - #{params[:song][:concert_ids]} - #{@song.id} - #{params[:song][:s_o]} - #{params[:song][:s_o1]}"
        if !params[:song][:concert_ids][0].nil?
          @program = Program.find_by_concert_id_and_song_id(params[:song][:concert_ids][0],@song.id)
          @program.song_order = params[:song][:s_o]
          @program.save
          puts "Song Id: #{@song.id} Concert ID: #{params[:song][:concert_ids][0]} Song Name: #{@song.name} Song Order: #{@program.song_order}"
        end
       if !params[:song][:concert_ids][1].nil?
          @program = Program.find_by_concert_id_and_song_id(params[:song][:concert_ids][1],@song.id)
          @program.song_order = params[:song][:s_o1]
          @program.save
          puts "Song Id: #{@song.id} Concert ID: #{params[:song][:concert_ids][1]} Song Name: #{@song.name} Song Order: #{@program.song_order}"
        end

        if false
        for concert in Concert.all
          if !concert.songs.find_by_name(@song.name).nil?
            sid = concert.songs.find_by_name(@song.name).id   # get id of song in this concert
            @program = Program.find_by_concert_id_and_song_id(concert.id,sid)           # create program instance
            #@program.nil?
            @program.song_order = @song[:s_o]                  # update value
            #puts "Song Id: #{sid} Concert ID: #{concert.id} Song Name: #{@song.name} Song Order: #{@song[:s_o]}"
            @program.save      
          end                               # save it
        end     
        end

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
      params.require(:song).permit(:name, :source, :composer, :lyricist, :arranger, :genre, :song_type, :notes, {:singer_ids => []}, {:concert_ids => []}, :s_o, :s_o1, :s_o2, :s_o3,  programs_attributes: [ :song_order ] )
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
