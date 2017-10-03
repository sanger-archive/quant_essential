class StandardsController < ApplicationController
  def index
    @filtered = filtered?
    @standards = Standard.include_for_list.where(search_params).latest_first.page(params[:page])
  end

  def show
    @standard = Standard.include_for_list.with_barcode(params[:barcode]).first!
    @subtitle = @standard.barcode
  end

  private

  def search_params
    params.permit('lot_number').delete_if { |_k, v| v.blank? }
  end

  def filtered?
    search_params.present?
  end
end
