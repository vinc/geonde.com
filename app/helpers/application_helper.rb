module ApplicationHelper
  def time_ago(time)
    time_tag(time, time_ago_in_words(time), title: time)
  end

  def form_errors_heading(resource)
    I18n.t(
      "errors.messages.not_saved",
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase,
    )
  end

  SOURCES = {
    "elexon" => ["Elexon", "https://bmrs.elexon.co.uk/"],
    "entsoe" => ["ENTSO-E", "https://transparency.entsoe.eu/"],
    "geonames" => ["Geonames", "https://www.geonames.org/datasources/"],
    "gfs" => ["GFS", "https://www.nco.ncep.noaa.gov/pmb/products/gfs/"],
    "metar" => ["METAR", "https://tgftp.nws.noaa.gov/data/nsd_cccc.txt"],
    "nrel" => ["NREL", "https://www.nrel.gov/analysis/life-cycle-assessment.html"],
    "osm" => ["OSM", "https://www.openstreetmap.org/copyright"],
    "rte" => ["RTE", "https://data.rte-france.com/"],
    "ons" => ["ONS", "https://www.ons.org.br/paginas/energia-agora/carga-e-geracao/"],
    "eirgrid" => ["EirGrid", "https://www.eirgridgroup.com/"],
  }.freeze

  def link_to_source(name)
    link_to(*SOURCES[name])
  end
end
