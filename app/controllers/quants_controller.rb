class QuantsController < ApplicationController

  def create
    qar = QuantAttributeReader.new(params[:quant])

    if qar.validate_and_create_quant
      @quant = qar.quant
      redirect_to quant_path(qar.quant.assay_barcode), notice: t('.success')
    else
      @quant = qar
      @quant_types = QuantType.alphabetical.pluck(:name,:id)
      flash.now.alert = qar.valid? ? quant.errors.full_messages : qar.errors.full_messages
      render :new
      return
    end

  end

  def new
    @quant = Quant.new
    @quant_types = QuantType.alphabetical.pluck(:name,:id)
  end

  def index
    @quants = Quant.latest_first.page(params[:page])
  end

  def show
    @quant = Quant.with_assay_barcode(params[:assay_barcode]).first!
    @subtitle = @quant.name
  end

end
