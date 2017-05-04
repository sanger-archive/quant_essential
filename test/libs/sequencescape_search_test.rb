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

  def searches_response
    %Q{{
      "actions":{"read":"http://example.com/api/1/searches/1","first":"http://example.com/api/1/searches/1","last":"http://example.com/api/1/searches/1"},
      "size":3,
      "searches":[
        {"created_at":"2011-03-23 16:15:12 +0000","updated_at":"2011-03-23 16:15:12 +0000","actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000002","first":"http://example.com/api/1/00000000-0000-0000-0000-000000000002/first","last":"http://example.com/api/1/00000000-0000-0000-0000-000000000002/last","all":"http://example.com/api/1/00000000-0000-0000-0000-000000000002/all","first":"http://example.com/api/1/00000000-0000-0000-0000-000000000002/first","last":"http://example.com/api/1/00000000-0000-0000-0000-000000000002/last","all":"http://example.com/api/1/00000000-0000-0000-0000-000000000002/all"},"uuid":"00000000-0000-0000-0000-000000000002","name":"Find assets by barcode"},
        {"created_at":"2011-08-05 18:22:54 +0100","updated_at":"2011-08-05 18:22:54 +0100","actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000003","first":"http://example.com/api/1/00000000-0000-0000-0000-000000000003/first","last":"http://example.com/api/1/00000000-0000-0000-0000-000000000003/last","all":"http://example.com/api/1/00000000-0000-0000-0000-000000000003/all","first":"http://example.com/api/1/00000000-0000-0000-0000-000000000003/first","last":"http://example.com/api/1/00000000-0000-0000-0000-000000000003/last","all":"http://example.com/api/1/00000000-0000-0000-0000-000000000003/all"},"uuid":"00000000-0000-0000-0000-000000000003","name":"Find user by login"},
        {"created_at":"2011-08-05 18:22:55 +0100","updated_at":"2011-08-05 18:22:55 +0100","actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000001","first":"http://example.com/api/1/00000000-0000-0000-0000-000000000001/first","last":"http://example.com/api/1/00000000-0000-0000-0000-000000000001/last","all":"http://example.com/api/1/00000000-0000-0000-0000-000000000001/all","first":"http://example.com/api/1/00000000-0000-0000-0000-000000000001/first","last":"http://example.com/api/1/00000000-0000-0000-0000-000000000001/last","all":"http://example.com/api/1/00000000-0000-0000-0000-000000000001/all"},"uuid":"00000000-0000-0000-0000-000000000001","name":"Find user by swipecard code"}
      ]
    }}
  end

  def user_response
    %Q{{
      "user":{
        "created_at":"2012-05-22 12:01:41 +0100",
        "updated_at":"2016-03-31 16:51:30 +0100",
        "actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000004"},
        "uuid":"00000000-0000-0000-0000-000000000004",
        "barcode":"ID000000",
        "email":"example@example.com",
        "first_name":"Joe",
        "has_a_swipecard_code":true,
        "last_name":"Bloggs",
        "login":"jb00"
      }
    }}
  end

  def plate_response
    %Q{{
      "plate":{
        "created_at":"2015-04-10 15:51:15 +0100",
        "updated_at":"2015-04-30 09:36:59 +0100",
        "comments":{"size":0,"actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000005/comments"}},
        "wells":{"size":88,"actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000005/wells"}},
        "submission_pools":{"size":0,"actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000005/submission_pools"}},
        "requests":{"size":0,"actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000005/requests"}},
        "qc_files":{"size":0,"actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000005/qc_files"}},
        "source_transfers":{"size":0,"actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000005/source_transfers"}},
        "transfers_to_tubes":{"size":0,"actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000005/transfers_to_tubes"}},
        "creation_transfers":{"size":0,"actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000005/creation_transfers"}},
        "plate_purpose":{"actions":{"read":"http://example.com/api/1/fd2f0c00-e7d7-11e2-ab4e-68b599768938"},"uuid":"fd2f0c00-e7d7-11e2-ab4e-68b599768938","lifespan":null,"name":"Cherrypicked"},
        "actions":{"read":"http://example.com/api/1/00000000-0000-0000-0000-000000000005"},
        "uuid":"00000000-0000-0000-0000-000000000005",
        "name":"Cherrypicked 397032",
        "qc_state":"pending",
        "barcode":{"ean13":"1220397032777","number":"397032","prefix":"DN","two_dimensional":null,"type":1},
        "iteration":4,"label":{"prefix":null,"text":"Cherrypicked"},
        "location":"Illumina high throughput freezer","pools":{},
        "pre_cap_groups":{},
        "priority":0,
        "size":96,
        "state":"pending",
        "stock_plate":{"barcode":{"ean13":"1220397032777","number":"397032","prefix":"DN","two_dimensional":null,"type":1},
        "uuid":"00000000-0000-0000-0000-000000000005"}}}
    }
  end
end
