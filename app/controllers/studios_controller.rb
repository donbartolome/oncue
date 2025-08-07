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
      render :new, status: :unprocessable_content
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
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @studio.destroy
    redirect_to studios_path, notice: "Studio was successfully destroyed."
  end

  def roster
    @studio = Studio.find(params[:id])
    @roster = @studio.people.joins(:studio_memberships).where(studio_memberships: { role: :dancer })
  end

  def new_dancer
    @studio = Studio.find(params[:id])
    @dancer = @studio.people.new
  end

  def add_dancer
    @studio = Studio.find(params[:id])
    @dancer = Person.find_or_initialize_by(first_name: person_params[:first_name], last_name: person_params[:last_name])

    if @dancer.new_record?
      @dancer.assign_attributes(person_params)
      if !@dancer.save
        return render :new_dancer, status: :unprocessable_content
      end
    end

    if @studio.add_dancer(@dancer)
      redirect_to roster_studio_path(@studio), notice: "Dancer was successfully added."
    else
      render :new_dancer, status: :unprocessable_content
    end
  end

  private

  def set_studio
    @studio = Studio.find(params[:id])
  end

  def studio_params
    params.expect(studio: [ :name, :address_line1, :address_line2, :city, :state, :zip_code ])
  end

  def person_params
    params.expect(person: [ :first_name, :last_name ])
  end
end
