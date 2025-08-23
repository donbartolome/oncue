class SeasonsController < ApplicationController
  before_action :set_season, only: %i[ show edit update destroy ]
  before_action :set_studio, only: %i[ index new create ]

  # GET /studios/:studio_id/seasons
  def index
    @seasons = @studio.seasons
  end

  # GET /seasons/:studio_id
  def show
  end

  # GET /studios/:studio_id/seasons/new
  def new
    @season = @studio.seasons.build
  end

  # GET /seasons/:studio_id/edit
  def edit
  end

  # POST /studios/:studio_id/seasons
  def create
    @season = @studio.seasons.build(season_params)

    if @season.save
      redirect_to @season, notice: "Season was successfully created."
    else
      redirect_to new_studio_season_path, alert: @season.errors.full_messages.to_sentence
    end
  end

  # PATCH/PUT /seasons/:studio_id
  def update
    if @season.update(season_params)
      redirect_to @season, notice: "Season was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /seasons/:studio_id
  def destroy
    @season.destroy!

    redirect_to studio_seasons_path(@season.studio), status: :see_other, notice: "Season was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season
      @season = Season.find(params.expect(:id))
    end

    def set_studio
      @studio = Studio.find(params.expect(:studio_id))
    end

    # Only allow a list of trusted parameters through.
    def season_params
      params.expect(season: [ :name, :start_year, :end_year, :studio_id ])
    end
end
