class QuantTypesController < ApplicationController
  def new
    @quant_type = QuantType.new
    @standard_types = StandardType.alphabetical.pluck(:name,:id)
  end

  def edit
    @quant_type = QuantType.find(params[:id])
    @standard_types = StandardType.alphabetical.pluck(:name,:id)
  end

  def index
    @quant_types = QuantType.alphabetical.page(params[:page])
  end

  def show
    @quant_type = QuantType.find(params[:id])
  end

  def create
    @quant_type = QuantType.new(quant_type_attributes)
    if @quant_type.save
      redirect_to quant_type_path(@quant_type)
    else
      render :new
    end
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
    params.require(:quant_type).permit(:name,:standard_type_id)
  end
end
