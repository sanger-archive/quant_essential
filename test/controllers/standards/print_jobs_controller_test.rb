# frozen_string_literal: true

require 'test_helper'
require 'mocha/test_unit'
module Standards
  class PrintJobsControllerTest < ActionController::TestCase
    setup do
      @printer = create :printer, name: 'example'
      PrintJob.any_instance.stubs(:print).returns(true)
    end

    test 'standard labels can be printed' do
      @standard = create :standard
      expected_labels = [@standard].map { |s| { label: { top_line: s.standard_type.name, bottom_line: s.barcode, barcode: s.barcode } } }
      post :create, standard_barcode: @standard.barcode, print_job: { printer: 'example' }
      assert assigns(:print_job)
      assert_equal expected_labels, assigns(:print_job).printables
      assert_equal 'Your label has been sent to example', flash.notice
    end
  end
end
