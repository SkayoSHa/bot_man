# frozen_string_literal: true

json.servers do
  json.array!(@servers) do |server|
    json.uid server.uid.to_s
    json.name server.name
    json.icon_url server.icon_url
  end
end
