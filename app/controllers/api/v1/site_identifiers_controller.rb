class Api::V1::SiteIdentifiersController < ApplicationController

    def index
        render json: SiteIdentifier.all
    end

end