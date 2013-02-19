class AdditionalServiceRecordsController < ApplicationController
  # GET /additional_service_records
  # GET /additional_service_records.json
  def index
    @additional_service_records = AdditionalServiceRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @additional_service_records }
    end
  end

  # GET /additional_service_records/1
  # GET /additional_service_records/1.json
  def show
    @additional_service_record = AdditionalServiceRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @additional_service_record }
    end
  end

  # GET /additional_service_records/new
  # GET /additional_service_records/new.json
  def new
    @additional_service_record = AdditionalServiceRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @additional_service_record }
    end
  end

  # GET /additional_service_records/1/edit
  def edit
    @additional_service_record = AdditionalServiceRecord.find(params[:id])
  end

  # POST /additional_service_records
  # POST /additional_service_records.json
  def create
    @additional_service_record = AdditionalServiceRecord.new(params[:additional_service_record])

    respond_to do |format|
      if @additional_service_record.save
        format.html { redirect_to @additional_service_record, notice: 'Additional service record was successfully created.' }
        format.json { render json: @additional_service_record, status: :created, location: @additional_service_record }
      else
        format.html { render action: "new" }
        format.json { render json: @additional_service_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /additional_service_records/1
  # PUT /additional_service_records/1.json
  def update
    @additional_service_record = AdditionalServiceRecord.find(params[:id])

    respond_to do |format|
      if @additional_service_record.update_attributes(params[:additional_service_record])
        format.html { redirect_to @additional_service_record, notice: 'Additional service record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @additional_service_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /additional_service_records/1
  # DELETE /additional_service_records/1.json
  def destroy
    @additional_service_record = AdditionalServiceRecord.find(params[:id])
    @additional_service_record.destroy

    respond_to do |format|
      format.html { redirect_to additional_service_records_url }
      format.json { head :no_content }
    end
  end
end
