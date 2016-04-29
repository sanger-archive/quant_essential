module UuidReaders

  FULL_UUID = /\A\h{8}(?:-\h{4}){3}-\h{12}\z/
  FRIENDLY_UUID = /\A[A-z0-9]+\z/
  FRIENDLY_ENCODING = 36

  def uuid_from_parameters
    return params[:uuid] if FULL_UUID === params[:uuid]
    return UUIDTools::UUID.parse_int(params[:uuid].to_i(FRIENDLY_ENCODING)) if FRIENDLY_UUID === params[:uuid]
    nil
  end
end
