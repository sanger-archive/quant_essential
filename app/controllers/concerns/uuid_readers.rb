# frozen_string_literal: true

module UuidReaders
  FULL_UUID = /\A\h{8}(?:-\h{4}){3}-\h{12}\z/
  FRIENDLY_UUID = /\A[A-z0-9]+\z/
  FRIENDLY_ENCODING = 36

  private

  def uuid_from_parameters
    uuid_from(params[:uuid])
  end

  def uuid_from(param)
    return param if FULL_UUID === param
    return UUIDTools::UUID.parse_int(param.to_i(FRIENDLY_ENCODING)) if FRIENDLY_UUID === param
    nil
  end
end
