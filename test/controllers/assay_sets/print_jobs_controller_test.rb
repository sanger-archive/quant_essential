# frozen_string_literal: true

require 'test_helper'
require 'mocha/test_unit'

module AssaySets
  class PrintJobsControllerTest < ActionController::TestCase
    setup do
      @printer = create :printer, name: 'example'
      PrintJob.any_instance.stubs(:print).returns(true)
    end

    test 'assay sets labels can be printed' do
      @assay_set = create :assay_set, assay_count: 2
      expected_labels = @assay_set.assays.map { |a| { label: { top_line: 'Assay', bottom_line: a.barcode, barcode: a.barcode } } }
      post :create, assay_set_uuid: @assay_set.friendly_uuid, print_job: { printer: 'example' }
      assert assigns(:print_job)
      assert_equal expected_labels, assigns(:print_job).printables
      assert_equal 'example', assigns(:print_job).printer
      assert_equal '2 labels have been sent to example', flash.notice
    end
  end
end
