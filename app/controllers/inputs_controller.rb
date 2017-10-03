# frozen_string_literal: true

class InputsController < ApplicationController
  def show
    @input = Input.with_parameters(params).first!
    @quants = @input.quants.latest_first.page(params[:page])
    @subtitle = @input.name

    respond_to do |format|
      format.html
      format.text { render plain: @input.uuid }
    end
  end

  def index
    @inputs = Input.include_for_list.latest_first.page(params[:page])
  end
end
