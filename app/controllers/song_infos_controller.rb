class SongInfosController < ApplicationController
  before_action :set_song_info, only: [:show, :edit, :update, :destroy]

  # GET /song_infos
  # GET /song_infos.json
  def index
    @song_infos = SongInfo.all
  end

  # GET /song_infos/1
  # GET /song_infos/1.json
  def show
  end

  # GET /song_infos/new
  def new
    @song_info = SongInfo.new
  end

  # GET /song_infos/1/edit
  def edit
  end

  # POST /song_infos
  # POST /song_infos.json
  def create
    @song_info = SongInfo.new(song_info_params)

    respond_to do |format|
      if @song_info.save
        format.html { redirect_to @song_info, notice: 'Song info was successfully created.' }
        format.json { render :show, status: :created, location: @song_info }
      else
        format.html { render :new }
        format.json { render json: @song_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /song_infos/1
  # PATCH/PUT /song_infos/1.json
  def update
    respond_to do |format|
      if @song_info.update(song_info_params)
        format.html { redirect_to @song_info, notice: 'Song info was successfully updated.' }
        format.json { render :show, status: :ok, location: @song_info }
      else
        format.html { render :edit }
        format.json { render json: @song_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /song_infos/1
  # DELETE /song_infos/1.json
  def destroy
    @song_info.destroy
    respond_to do |format|
      format.html { redirect_to song_infos_url, notice: 'Song info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song_info
      @song_info = SongInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_info_params
      params.require(:song_info).permit(:search_by, :website, :status, :web_template, :user_id)
    end
end
