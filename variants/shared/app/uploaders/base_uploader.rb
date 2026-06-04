# frozen_string_literal: true

class BaseUploader < Shrine
  def generate_location(io, record: nil, derivative: nil, **)
    return super unless record

    table = record.class.table_name
    id = record.id
    prefix = derivative || "original"

    "#{table}/#{id}/#{prefix}-#{super}"
  end
end
