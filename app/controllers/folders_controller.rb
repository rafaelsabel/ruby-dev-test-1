class FoldersController < ApplicationController
  before_action :set_folder, only: [:edit, :update, :destroy]

  def index
    @folders = Folder.where(top_folder_id: nil)
    @folders = @folders.unscoped if params[:all].present?
  end

  def show
    @folder = Folder.where(id: params[:id]).includes(:subfolders).with_attached_files.first
  end

  def new
    @folder = Folder.new(top_folder_id: params['top_folder_id'])
  end

  def edit
  end

  def create
    @folder = Folder.new(folder_params)

    respond_to do |format|
      if @folder.save
        format.html { redirect_to (@folder.top_folder_id.present? ? @folder.top_folder : folders_path), notice: 'Pasta criada com sucesso.' }
        format.json { render json: @folder.id, status: :created, location: @folder }
      else
        format.html { render :new }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to (@folder.top_folder_id.present? ? @folder.top_folder : folders_path), notice: 'Pasta alterada com sucesso.' }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to (@folder.top_folder_id.present? ? @folder.top_folder : folders_path), notice: 'Pasta excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :top_folder_id)
  end
end
