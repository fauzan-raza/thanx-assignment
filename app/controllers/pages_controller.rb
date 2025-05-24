class PagesController < ApplicationController
    skip_before_action :authorize_request, only: [ :index ]

    def index
      # render file: "pages/index"
      # render layout: "application"
    end

    def signup
    end

    def login
    end
end
