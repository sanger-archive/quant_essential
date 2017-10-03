# frozen_string_literal: true

class BarcodesController < ApplicationController
  def show
    @barcode = params.require(:barcode).squish
    result = Barcode.find_barcodable_with_barcode(@barcode)

    if result
      redirect_to result
    else
      render :show, status: :not_found
    end
  end

  # This is a bit naughty, but essentially this means
  # our form can act as though getting /barcode?barcode=example is the same
  # as getting /barcode/example
  alias :index :show
end
