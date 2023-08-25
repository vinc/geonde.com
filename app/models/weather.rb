require "metar"

class Weather
  def initialize(latitude: 0, longitude: 0, time: Time.zone.now, metar: nil)
    @lat = latitude
    @lon = longitude

    if metar.present?
      @metar = true
      @data = metar
    else
      @data = GfsData.new(time)
    end
  end

  def time
    @data.time
  end

  def temperature
    if @metar
      @data.temperature&.value&.round(1)
    else
      (read(:tmp).to_f - 273.15).round(1)
    end
  end

  def humidity
    if @metar
      t = @data.temperature&.value
      d = @data.dew_point&.value
      return if (t || d).nil?
      e = Math::E
      num = e**((17.625 * d) / (243.04 + d))
      den = e**((17.625 * t) / (243.04 + t))
      ((num / den) * 100).round
    else
      read(:rh).to_i
    end
  end

  def pressure
    if @metar
      (@data.sea_level_pressure.value * 1000).round(1) if @data.sea_level_pressure
    else
      (read(:mslet).to_f / 100.0).round(1)
    end
  end

  def precipitation
    if @metar
      nil
    else
      (read(:prate).to_f * 3600).round(1)
    end
  end

  def wind
    if @metar
      @data.wind.speed&.value&.round(1)
    else
      u = read(:ugrd).to_f
      v = read(:vgrd).to_f
      Math.sqrt((u**2) + (v**2)).round(1)
    end
  end

  def wind_direction
    if @metar
      @data.wind.direction&.value&.round
    else
      u = read(:ugrd).to_f
      v = read(:vgrd).to_f
      ((270 - (Math.atan2(u, v) * 180 / Math::PI)) % 360).round
    end
  end

  def nebulosity
    if @metar
      nil
    else
      read(:tcdc).to_i
    end
  end

  def radiation
    if @metar
      nil
    else
      read(:dswrf).to_i
    end
  end

  def read(key)
    @data.read(key, latitude: @lat, longitude: @lon)
  end
end
