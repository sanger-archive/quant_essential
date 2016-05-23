require 'test_helper'
require 'mocha/test_unit'

class PrintJobsControllerTest < ActionController::TestCase

  setup do
    @printer = create :printer, name: 'example'
    template_id = @printer.label_template.external_id
    PrintJob.any_instance.stubs(:print).returns(true)
  end

  test "assay sets labels can be printed" do
    @assay_set = create :assay_set, assay_count: 2
    expected_labels = @assay_set.assays.map {|a| {label:{top_line:"Assay",bottom_line:a.barcode,barcode:a.barcode}} }
    post :create, assay_set_uuid: @assay_set.friendly_uuid, printer: 'example'
    assert assigns(:print_job)
    assert_equal @assay_set.assays, assigns(:print_job).printables
    assert_equal "2 labels have been sent to example", flash.notice
  end

  test "assay labels can be printed" do
    @assay = create :assay
    expected_labels = [@assay].map {|a| {label:{top_line:"Assay",bottom_line:a.barcode,barcode:a.barcode}} }
    post :create, assay_barcode: @assay.barcode, printer: 'example'
    assert assigns(:print_job)
    assert_equal [@assay], assigns(:print_job).printables
    assert_equal "Your label has been sent to example", flash.notice
  end

  test "standard_set labels can be printed" do
    @standard_set = create :standard_set, standard_count: 2
    expected_labels = @standard_set.standards.map {|s| {label:{top_line:s.standard_type.name,bottom_line:s.barcode,barcode:s.barcode}} }
    post :create, standard_set_uuid: @standard_set.friendly_uuid, printer: 'example'
    assert assigns(:print_job)
    assert_equal @standard_set.standards, assigns(:print_job).printables
    assert_equal "2 labels have been sent to example", flash.notice
  end

  test "standard labels can be printed" do
    @standard = create :standard
    expected_labels = [@standard].map {|s| {label:{top_line:s.standard_type.name,bottom_line:s.barcode,barcode:s.barcode}} }
    post :create, standard_barcode: @standard.barcode, printer: 'example'
    assert assigns(:print_job)
    assert_equal [@standard], assigns(:print_job).printables
    assert_equal "Your label has been sent to example", flash.notice
  end

end
