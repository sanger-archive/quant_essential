# frozen_string_literal: true

class PrintersController < ApplicationController
  before_action :find_printer, except: %i[create new index]

  def create
    @printer = Printer.new(printer_params)

    if @printer.save
      flash.merge!(report)
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
    @subtitle = @printer.name
  end

  def edit
    @subtitle = @printer.name
  end

  def update
    @printer.update_attributes(printer_params)
    if @printer.save
      redirect_to printer_path(@printer.name), notice: t('.success', name: @printer.name)
    else
      flash.now.alert = @printer.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @printer.destroy
      redirect_to printers_path, notice: t('.success', name: @printer.name)
    else
      redirect_to printer_path(@printer), alert: @printer.errors.full_messages
    end
  end

  private

  #
  # Provides status information to the flash
  # success: The printer was created and exists externally
  # warn: The printer was created, but isn't in PMB
  # warn: We couldn't connect to PMB to verify the printer
  # @return [<type>] <description>
  #
  def report
    if @printer.exists_externally?
      { notice: t('.success', name: @printer.name) }
    else
      { warn: t('.warn_no_external', name: @printer.name) }
    end
  rescue JsonApiClient::Errors::ServerError
    { warn: t('.warn_no_connection', name: @printer.name) }
  end

  def find_printer
    @printer = Printer.find_by!(name: params[:name])
  end

  def printer_params
    params.require(:printer).permit(:name, :label_template_id, :description).transform_values(&:squish)
  end
end
