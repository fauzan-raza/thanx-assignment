class PagesController < ApplicationController
    skip_before_action :authorize_request, only: [:index]

    def index
        # render file: "pages/index"
        # no need to render explicitly — Rails renders index.html.erb by default
        # render layout: "application"
    end

    def signup
    end

    def login
    end
end
