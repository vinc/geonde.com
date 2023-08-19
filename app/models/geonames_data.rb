class GeonamesData < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search, against: :name
end
