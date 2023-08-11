# frozen_string_literal: true

class PagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def home
  end
end
