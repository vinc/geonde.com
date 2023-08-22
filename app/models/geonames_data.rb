class GeonamesData < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: :name, order_within_rank: "population DESC", using: {
    tsearch: { normalization: 2 },
  }
end
