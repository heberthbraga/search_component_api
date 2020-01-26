module RequestSpecHelper
  def json_response
    expect(response.body).not_to be_nil

    JSON.parse(response.body)
  end
end