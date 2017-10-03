# frozen_string_literal: true

class PrintersController < ApplicationController
  def create
    @printer = Printer.create(printer_params)
    if @printer.save
      begin
        if @printer.exists_externally?
          flash.notice = t('.success', name: @printer.name)
        else
          flash[:warn] = t('.warn_no_external', name: @printer.name)
        end
      rescue JsonApiClient::Errors::ServerError
        flash[:warn] = t('.warn_no_connection', name: @printer.name)
      end
      redirect_to printer_path(@printer.name)
    else
      flash.now.alert = @printer.errors.full_messages
      render :new
    end
  end

  def new
    @printer = Printer.new
    @label_templates = LabelTemplate.pluck(:id, :name)
  end

  def index
    @printers = Printer.alphabetical
  end

  def show
    @printer = Printer.find_by!(name: params[:name])
    @subtitle = @printer.name
  end

  def edit
    @printer = Printer.find_by!(name: params[:name])
    @subtitle = @printer.name
  end

  def update
    @printer = Printer.find_by!(name: params[:name])
    @printer.update_attributes(printer_params)
    if @printer.save
      redirect_to printer_path(@printer.name), notice: t('.success', name: @printer.name)
    else
      flash.now.alert = @printer.errors.full_messages
      render :edit
    end
  end

  def destroy
    @printer = Printer.find_by!(name: params[:name])
    if @printer.destroy
      redirect_to printers_path, notice: t('.success', name: @printer.name)
    else
      redirect_to printer_path(@printer), alert: @printer.errors.full_messages
    end
  end

  private

  def printer_params
    params.require(:printer).permit(:name, :label_template_id, :description).transform_values { |v| v.squish }
  end
end
