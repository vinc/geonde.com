module ApplicationHelper
  def link_to_source(name)
    case name
      when "elexon" then link_to("Elexon", "https://bmrs.elexon.co.uk/")
      when "entsoe" then link_to("ENTSO-E", "https://transparency.entsoe.eu/")
      when "gfs" then link_to("GFS", "https://www.nco.ncep.noaa.gov/pmb/products/gfs/")
      when "rte" then link_to("RTE", "https://data.rte-france.com/")
      when "nrel" then link_to("NREL", "https://www.nrel.gov/analysis/life-cycle-assessment.html")
    end
  end
end
