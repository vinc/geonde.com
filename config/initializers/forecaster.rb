Forecaster.configure do |config|
  config.wgrib2_path = "/usr/local/bin/wgrib2"
  config.cache_dir = Rails.root.join("tmp", "gfs").to_s
  config.records = {
    prate: ":PRATE:surface:",
    sunsd: ":SUNSD:surface:",
    dswrf: ":DSWRF:surface:",
    pres:  ":PRES:surface:",
    tmp:   ":TMP:surface:",
    rh:    ":RH:2 m above ground:",
    ugrd:  ":UGRD:10 m above ground:",
    vgrd:  ":VGRD:10 m above ground:",
    tcdc:  ":TCDC:entire atmosphere:",
    #pwat:  ":PWAT:entire atmosphere",
  }
end
