# frozen_string_literal: true

class AssaySetsController < ApplicationController
  include UuidReaders

  def create
    @assay_set = AssaySet.new(assay_set_params)
    if @assay_set.save
      redirect_to assay_set_path(@assay_set), notice: t('.success', count: @assay_set.assay_count)
    else
      flash.now.alert = @assay_set.errors.full_messages
      render :new
    end
  end

  def new
    @assay_set = AssaySet.new
  end

  def index
    @assay_sets = AssaySet.latest_first.page(params[:page])
  end

  def show
    @assay_set = AssaySet.find_by!(uuid: uuid_from_parameters)
    @assays = @assay_set.assays.latest_first.include_for_list.page(params[:page])
    @subtitle = l(@assay_set.created_at, format: :long)
  end

  private

  def assay_set_params
    params.required(:assay_set).permit(:assay_count)
  end
end
