class HomeController < ApplicationController

    def index
        @adicoes=Material.order(id: :desc).limit(10)
        
    end

end
