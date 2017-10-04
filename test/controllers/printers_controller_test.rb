# frozen_string_literal: true

require 'test_helper'

class PrintersControllerTest < ActionController::TestCase
  test '#create with valid_printer' do
    Printer.stubs(:external_printers).returns(['valid_printer'])
    label_template = create :label_template
    assert_difference('Printer.count') do
      post :create, printer: { name: 'valid_printer', label_template_id: label_template.id, description: 'Happy Printer' }
    end
    assert assigns(:printer)
    assert_redirected_to printer_path(assigns(:printer).name)
    assert_equal 'Happy Printer', assigns(:printer).description
    assert_equal "Printer 'valid_printer' created", flash.notice
  end

  test '#create with invalid_printer' do
    Printer.stubs(:external_printers).returns(['valid_printer'])
    label_template = create :label_template
    assert_difference('Printer.count') do
      post :create, printer: { name: 'invalid_printer', label_template_id: label_template.id, description: 'Sad Printer' }
    end
    assert assigns(:printer)
    assert_redirected_to printer_path(assigns(:printer).name)
    assert_equal 'Sad Printer', assigns(:printer).description
    assert_equal(
      "Printer 'invalid_printer' is not registered in print my barcode. "\
      'Any attempts to select the printer will result in an error message, until this issue is resolved.',
      flash[:warn]
    )
  end

  test '#new' do
    Printer.stubs(:external_printers).returns(['valid_printer'])
    get :new
    assert assigns(:printer)
  end

  test '#index' do
    get :index
    printer = create :printer
    assert assigns(:printers)
    assert_includes assigns(:printers), printer
  end

  test '#show' do
    printer = create :printer
    get :show, name: printer.name
    assert_equal printer, assigns(:printer)
  end

  test '#edit' do
    Printer.stubs(:external_printers).returns(['valid_printer'])
    printer = create :printer
    get :edit, name: printer.name
    assert_equal printer, assigns(:printer)
  end

  test '#update' do
    printer = create :printer
    label_template2 = create :label_template
    put :update, name: printer.name, printer: { name: 'new_name', description: 'Smile', label_template_id: label_template2.id }
    assert_equal printer, assigns(:printer)
    assert_equal label_template2, assigns(:printer).label_template
    assert_equal 'Smile', assigns(:printer).description
    assert_redirected_to printer_path('new_name')
  end

  test '#destroy' do
    printer = create :printer
    assert_difference('Printer.count', -1) do
      delete :destroy, name: printer.name
    end
    assert_redirected_to printers_path
    assert_equal "Printer '#{printer.name}' has been removed", flash.notice
  end
end
