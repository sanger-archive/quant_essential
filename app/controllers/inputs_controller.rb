class InputsController < ApplicationController
  def show
    @input = Input.with_barcode(params[:barcode]).first!
    @quants = @input.quants.latest_first.page(params[:page])
    @subtitle = @input.name
  end

  def index
    @inputs = Input.include_for_list.latest_first.page(params[:page])
  end
end
