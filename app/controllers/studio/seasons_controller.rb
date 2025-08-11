class Studio::SeasonsController < ApplicationController
  before_action :set_studio_season, only: %i[ show edit update destroy ]

  # GET /studio/seasons or /studio/seasons.json
  def index
    @studio_seasons = Studio::Season.all
  end

  # GET /studio/seasons/1 or /studio/seasons/1.json
  def show
  end

  # GET /studio/seasons/new
  def new
    @studio_season = Studio::Season.new
  end

  # GET /studio/seasons/1/edit
  def edit
  end

  # POST /studio/seasons or /studio/seasons.json
  def create
    @studio_season = Studio::Season.new(studio_season_params)

    respond_to do |format|
      if @studio_season.save
        format.html { redirect_to @studio_season, notice: "Season was successfully created." }
        format.json { render :show, status: :created, location: @studio_season }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @studio_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /studio/seasons/1 or /studio/seasons/1.json
  def update
    respond_to do |format|
      if @studio_season.update(studio_season_params)
        format.html { redirect_to @studio_season, notice: "Season was successfully updated." }
        format.json { render :show, status: :ok, location: @studio_season }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @studio_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /studio/seasons/1 or /studio/seasons/1.json
  def destroy
    @studio_season.destroy!

    respond_to do |format|
      format.html { redirect_to studio_seasons_path, status: :see_other, notice: "Season was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_studio_season
      @studio_season = Studio::Season.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def studio_season_params
      params.expect(studio_season: [ :name, :start_year, :end_year, :studio_id ])
    end
end
