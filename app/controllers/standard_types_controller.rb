class StandardTypesController < ApplicationController

  def create
    @standard_type = StandardType.new(standard_type_attributes)
    if @standard_type.save
      redirect_to standard_type_path(@standard_type), notice: t('.success',name: @standard_type.name)
    else
      flash.now.alert = @standard_type.errors.full_messages
      render :new
    end
  end

  def index
    @standard_types = StandardType.alphabetical.page(params[:page])
  end

  def show
    @standard_type = StandardType.find(params[:id])
    @subtitle = @standard_type.name
  end

  def new
    @standard_type = StandardType.new
  end

  def edit
    @standard_type = StandardType.find(params[:id])
  end

  def update
    @standard_type = StandardType.find(params[:id])
    @standard_type.update_attributes(standard_type_attributes)
    if @standard_type.save
      redirect_to standard_type_path(@standard_type)
    else
      render :edit
    end
  end

  private

  def standard_type_attributes
    params.require(:standard_type).permit(:name)
  end
end
