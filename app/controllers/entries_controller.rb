class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  # GET /entries
  # GET /entries.json
  def index
    @entries = current_user.entries.order('entries.created_at DESC')
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    check_user
  end
  
  def check_user
    redirect_to root_path, notice: "Restricted area!" if !current_user.entries.include?(@entry)
  end

  # GET /entries/new
  def new
    @entry = current_user.entries.build
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.build(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to root_path, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:location, :rating, :content)
    end
    
    def correct_user
      @pin = current_user.entries.find_by(id: params[:id])
      redirect_to entries_path, notice: "not authorized to do that" if @entry.nil?
    end
    
end
