class StandardsController < ApplicationController
  def index
    @standards = Standard.latest_first.page(params[:page])
  end

  def show
    @standard = Standard.with_barcode(params[:barcode]).first!
  end
end
