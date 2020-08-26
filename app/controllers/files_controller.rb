class FilesController < ApplicationController
  before_action :set_folder, only: [:create, :destroy]

  def create
    respond_to do |format|
      if @folder.files.attach(params[:folder][:files])
        format.html { redirect_to folder_path(@folder) }
        format.json { render json: @folder.id, status: :created }
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @folder.files.find(params[:id]).purge
        format.html { redirect_to folder_path(@folder) }
        format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_folder
    @folder = Folder.find(params[:folder_id])
  end
end
