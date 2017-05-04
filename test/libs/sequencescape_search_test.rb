require 'test_helper'
require './lib/sequencescape_search'

class SequencescapeSearchTest < ActiveSupport::TestCase
  # The following code has been taken from the Illumina B app. (Albeit spread about the place)
  # We want to wrap this api
  #     user_search = api.search.find(Settings.searches["Find user by swipecard code"])
  #     user_search.first(:swipecard_code => card_id)

  test 'Looks up users via the api' do
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/searches') { |env| [200, {}, searches_response] }
      stub.post('/00000000-0000-0000-0000-000000000001/first', '{"search":{"swipecard_code":"test"}}') { |env| [301, {}, user_response] }
    end

    api = Faraday.new do |builder|
      builder.adapter :test, stubs
    end

    endpoint = SequencescapeSearch.swipecard_search

    search = SequencescapeSearch.new(api, endpoint)
    result = search.find('test')
    assert_equal({ uuid: "00000000-0000-0000-0000-000000000004", login: "jb00" }, result)

    stubs.verify_stubbed_calls
  end

  test 'Looks up plates via the api' do
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get('/searches') { |env| [200, {}, searches_response] }
      stub.post('/00000000-0000-0000-0000-000000000002/first', '{"search":{"barcode":"test"}}') { |env| [301, {}, plate_response] }
    end

    api = Faraday.new do |builder|
      builder.adapter :test, stubs
    end

    endpoint = SequencescapeSearch.plate_barcode_search

    search = SequencescapeSearch.new(api, endpoint)
    result = search.find('test')
    assert_equal({ uuid: "00000000-0000-0000-0000-000000000005", name: "Cherrypicked 397032", external_type: "Cherrypicked" }, result)

    stubs.verify_stubbed_calls
  end

  def api_response(file)
    File.read(Rails.root.join('test', 'fixtures', 'api_responses', "#{file}.json"))
  end

  def searches_response
    @searches_response ||= api_response('searches_response')
  end

  def user_response
    @user_response ||= api_response('user_response')
  end

  def plate_response
    @plate_response ||= api_response('plate_response')
  end
end
