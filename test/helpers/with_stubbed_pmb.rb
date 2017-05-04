
# Unfortunately the gem holds the configuration on the class
PMB::TestSuiteStubs = Faraday::Adapter::Test::Stubs.new
PMB::Base.connection.delete(Faraday::Adapter::NetHttp)
PMB::Base.connection.faraday.adapter :test, PMB::TestSuiteStubs

module WithStubbedPmb
  def print_job_response(name, external_id)
    %Q{{
      "data": {
        "id": "",
        "type": "print_jobs",
        "attributes": {
          "printer_name": "#{name}",
          "label_template_id": #{external_id},
          "labels": {
            "body": [
              {
                "label": {
                  "location": "location",
                  "parent_location": "parent_location",
                  "barcode": "barcode"
                }
              }
            ]
          }
        }
      }
    }}
  end

  # Note: PMB currently returns an invalid JSON API error response. We'll test the handling of that here
  def invalid_invalid_job_response
    %Q{{"errors":{"printer":["Printer does not exist"]}}}
  end

  # And once PMB gets corrected
  def valid_invalid_job_response
    %Q{{"errors":[{"title":"Printer does not exist"}]}}
  end

  def print_post(name, template)
    {
      "data": {
        "type": 'print_jobs',
        "attributes": {
          "printer_name": name,
          "label_template_id": template,
          "labels": { "body": [{ "label": { "test_atrr": 'test', "barcode": '12345' } }] }
        }
      }
    }.to_json
  end

  def printers_index
    %Q{{
        "data":[
          {"id":"1","type":"printers","attributes":{"name":"printer_a","protocol":"LPD"}},
          {"id":"2","type":"printers","attributes":{"name":"printer_b","protocol":"LPD"}}
        ]
      }}
  end
end
