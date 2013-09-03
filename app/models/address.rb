class Address
  extend ActiveModel::Naming
  include ActiveModel::Conversion  ## takes care of initialize for us
  attr_accessor :street, :city, :state, :zipcode, :creator_id

  def initialize(options={})

    @street = options[:street]
    @city = options[:city]
    @state = options[:state]
    @zipcode = options[:zipcode]
    @creator_id = options[:creator_id]
  end

  def persisted?; false; end

  def as_venue
    address = Geocoder.search("#{address}, #{city}, #{state} #{zipcode}")
    return nil if address.blank?

    latitude = address.first.latitude
    longitude = address.first.longitude
    Venue.new name: name, latitude: latitude, longitude: longitude, creator_id: creator_id
  end
end