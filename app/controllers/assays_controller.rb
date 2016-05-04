class AssaysController < ApplicationController

  def show
    @assay = Assay.with_barcode(params[:barcode]).first!
  end

  def index
    @assays = Assay.include_barcode.latest_first.page(params[:page])
  end
end
