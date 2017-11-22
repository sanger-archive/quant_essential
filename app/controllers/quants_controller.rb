# frozen_string_literal: true

class QuantsController < ApplicationController
  def create
    @quant = QuantAttributeReader.new(quant_attributes)

    if @quant.validate_and_create_quant
      redirect_to quant_path(@quant.assay_barcode), notice: t('.success')
    else
      @quant_types = QuantType.alphabetical.pluck(:name, :id)
      flash.now.alert = @quant.errors.full_messages
      render :new
    end
  end

  def new
    @quant = Quant.new(new_quant_params)
    @quant_types = QuantType.alphabetical.pluck(:name, :id)
  end

  def index
    @quants = Quant.latest_first.page(params[:page])
  end

  def show
    @quant = Quant.with_assay_barcode(params[:assay_barcode]).first!
    @subtitle = @quant.name
  end

  private

  def quant_attributes
    params.require(:quant)
          .permit(:swipecard_code, :quant_type, :assay_barcode, :standard_barcode, :input_barcode, :override_expiry_date)
          .transform_values(&:squish)
  end

  def new_quant_params
    params.permit(:quant_type_id)
  end
end
