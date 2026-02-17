class CompaniesController < ApplicationController

  def index
    # find all Company rows
    # render companies/index view
    @companies = Company.all
  end

  def show
    # find a Company
    @company = Company.find_by({"id"=> params["id"]})
    puts @company
    # render companies/show view with details about Company
  end

  def new
    # render view with new Company form
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to company_path(@company), notice: "Company was successfully created."
    else
      flash.now[:alert] = "Company could not be created."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

  # def edit
  #   # find a Company
  #   # render view with edit Company form
  # end

  # def update
  #   # find a Company
  #   # assign user-entered form data to Company's columns
  #   # save Company row
  #   # redirect user
  # end

  # def destroy
  #   # find a Company
  #   # destroy Company row
  #   # redirect user
  # end

end
