Forecaster.configure do |config|
  config.server = "https://nomads.ncep.noaa.gov/pub/data/nccf/com/gfs/prod"
  config.frequency = 1
  config.wgrib2_path = Rails.root.join("bin", "wgrib2").to_s
  config.cache_dir = Rails.root.join("tmp", "gfs").to_s
  config.records = {
    prate: ":PRATE:surface:",
    sunsd: ":SUNSD:surface:",
    dswrf: ":DSWRF:surface:",
    pres:  ":PRES:surface:",
    mslet: ":MSLET:mean sea level:",
    tmps:  ":TMP:surface:",
    tmp:   ":TMP:2 m above ground:",
    rh:    ":RH:2 m above ground:",
    ugrd:  ":UGRD:10 m above ground:",
    vgrd:  ":VGRD:10 m above ground:",
    tcdc:  ":TCDC:entire atmosphere:",
    #pwat:  ":PWAT:entire atmosphere",
  }
end
