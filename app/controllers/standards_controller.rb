class StandardsController < ApplicationController
  def index
    @standards = Standard.include_for_list.latest_first.page(params[:page])
  end

  def show
    @standard = Standard.include_for_list.with_barcode(params[:barcode]).first!
    @subtitle = @standard.barcode
  end
end
