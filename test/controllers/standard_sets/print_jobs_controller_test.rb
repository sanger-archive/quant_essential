# frozen_string_literal: true

require 'test_helper'
require 'mocha/test_unit'

module StandardSets
  class PrintJobsControllerTest < ActionController::TestCase
    setup do
      @printer = create :printer, name: 'example'
      PrintJob.any_instance.stubs(:print).returns(true)
    end

    test 'standard_set labels can be printed' do
      @standard_set = create :standard_set, standard_count: 2
      expected_labels = @standard_set.standards.map { |s| { label: { top_line: s.standard_type.name, bottom_line: s.barcode, barcode: s.barcode } } }
      post :create, standard_set_uuid: @standard_set.friendly_uuid, print_job: { printer: 'example' }
      assert assigns(:print_job)
      assert_equal expected_labels, assigns(:print_job).printables
      assert_equal '2 labels have been sent to example', flash.notice
    end
  end
end
