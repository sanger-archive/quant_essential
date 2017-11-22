# frozen_string_literal: true

require 'test_helper'
require 'mocha/test_unit'

module Assays
  class PrintJobsControllerTest < ActionController::TestCase
    setup do
      @printer = create :printer, name: 'example'
      PrintJob.any_instance.stubs(:print).returns(true)
    end

    test 'assay labels can be printed' do
      @assay = create :assay
      expected_labels = [@assay].map { |a| { label: { top_line: 'Assay', bottom_line: a.barcode, barcode: a.barcode } } }
      post :create, assay_barcode: @assay.barcode, print_job: { printer: 'example' }
      assert assigns(:print_job)
      assert_equal expected_labels, assigns(:print_job).printables
      assert_equal 'Your label has been sent to example', flash.notice
    end
  end
end
