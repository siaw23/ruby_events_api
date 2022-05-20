class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :end_date, :location, :twitter_handle
end
