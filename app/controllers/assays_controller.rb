# frozen_string_literal: true

class AssaysController < ApplicationController
  def index
    @assays = Assay.include_for_list.latest_first.page(params[:page])
  end

  def show
    @assay = Assay.with_barcode(params[:barcode]).first!
    @subtitle = @assay.barcode
  end
end
