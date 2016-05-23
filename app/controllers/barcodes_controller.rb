class BarcodesController < ApplicationController
  def show
    @barcode = params[:barcode].squish
    result = Barcode.find_by(barcode:@barcode)

    if result && result.barcodable
      redirect_to result.barcodable
    else
      render :show, status: :not_found
    end
  end

  # This is a bit naughty, but essentially this means
  # our form can act as though getting /barcode?barcode=example is the same
  # as getting /barcode/example
  alias :index :show
end
