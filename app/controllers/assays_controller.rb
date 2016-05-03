class AssaysController < ApplicationController

  def show
    @assay = Assay.with_barcode(params[:barcode]).first!
  end

  def index
    @assays = Assay.latest_first.page(params[:page])
  end
end
