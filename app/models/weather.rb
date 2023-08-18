# frozen_string_literal: true

class Weather
  def initialize(latitude: 0, longitude: 0, time: Time.now)
    @lat = latitude
    @lon = longitude
    @gfs = GfsData.new(time)
  end

  def time
    @gfs.time
  end

  def temperature
    (read(:tmp).to_f - 273.15).round(1)
  end

  def humidity
    read(:rh).to_i
  end

  def pressure
    (read(:mslet).to_f / 100.0).round(1)
  end

  def precipitation
    (read(:prate).to_f * 3600).round(1)
  end

  def wind
    u = read(:ugrd).to_f
    v = read(:vgrd).to_f
    Math.sqrt(u ** 2 + v ** 2).round(1)
  end

  def wind_direction
    u = read(:ugrd).to_f
    v = read(:vgrd).to_f
    ((270 - Math.atan2(u, v) * 180 / Math::PI) % 360).round
  end

  def nebulosity
    read(:tcdc).to_i
  end

  def radiation
    read(:dswrf).to_i
  end

  def read(key)
    @gfs.read(key, latitude: @lat, longitude: @lon)
  end
end
