module ApplicationHelper
  def time_ago(time)
    time_tag(time, time_ago_in_words(time), title: time)
  end

  def duration_to_human(duration)
    parts = []
    if duration > 86400
      parts << "#{(duration / 86400).to_i}h"
      duration %= 86400
    end
    if duration > 3600
      parts << "#{(duration / 3600).to_i}h"
      duration %= 3600
    end
    if duration > 60
      parts << "#{(duration / 60).to_i}m"
      duration %= 60
    end
    if duration > 0
      parts << "#{duration.to_i}s"
    end
    parts[0..1].join(" ")
  end

  def form_errors_heading(resource)
    I18n.t(
      "errors.messages.not_saved",
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase
    )
  end
  def link_to_source(name)
    case name
      when "elexon" then link_to("Elexon", "https://bmrs.elexon.co.uk/")
      when "entsoe" then link_to("ENTSO-E", "https://transparency.entsoe.eu/")
      when "gfs" then link_to("GFS", "https://www.nco.ncep.noaa.gov/pmb/products/gfs/")
      when "nrel" then link_to("NREL", "https://www.nrel.gov/analysis/life-cycle-assessment.html")
      when "osm" then link_to("OSM", "https://www.openstreetmap.org/copyright")
      when "rte" then link_to("RTE", "https://data.rte-france.com/")
    end
  end
end
