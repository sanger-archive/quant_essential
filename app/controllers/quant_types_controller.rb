class QuantTypesController < ApplicationController

  def create
    @quant_type = QuantType.new(quant_type_attributes)
    if @quant_type.save
      redirect_to quant_type_path(@quant_type), notice: t('.success',name: @quant_type.name)
    else
      @standard_types = StandardType.alphabetical.pluck(:name,:id)
      flash.now.alert = @quant_type.errors.full_messages
      render :new
    end
  end

  def new
    @quant_type = QuantType.new
    @standard_types = StandardType.alphabetical.pluck(:name,:id)
  end

  def index
    @quant_types = QuantType.alphabetical.page(params[:page])
  end

  def show
    @quant_type = QuantType.find(params[:id])
    @quants = @quant_type.quants.latest_first.page(params[:page])
    @subtitle = @quant_type.name
  end

  def edit
    @quant_type = QuantType.find(params[:id])
    @standard_types = StandardType.alphabetical.pluck(:name,:id)
  end

  def update
    @quant_type = QuantType.find(params[:id])
    @quant_type.update_attributes(quant_type_attributes)
    if @quant_type.save
      redirect_to quant_type_path(@quant_type)
    else
      render :edit
    end
  end

  private

  def quant_type_attributes
    params.require(:quant_type).permit(:name,:standard_type_id).transform_values {|v| v.squish }
  end
end
