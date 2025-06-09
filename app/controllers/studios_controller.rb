class StudiosController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]

  before_action :set_studio, only: %i[ show edit update destroy ]

  def index
    @studios = Studio.all
  end

  def new
    @studio = Studio.new
  end

  def create
    @studio = Studio.new(studio_params)
    if @studio.save
      redirect_to @studio, notice: "Studio was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @studio is set by before_action
  end

  def edit
    # @studio is set by before_action
  end

  def update
    if @studio.update(studio_params)
      redirect_to @studio, notice: "Studio was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @studio.destroy
    redirect_to studios_path, notice: "Studio was successfully destroyed."
  end

  private

  def set_studio
    @studio = Studio.find(params[:id])
  end

  def studio_params
    params.expect(studio: [ :name, :address_line1, :address_line2, :city, :state, :zip_code ])
  end
end
