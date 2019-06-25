class BookmarksController < ApplicationController
    def create
        @material = Material.find(params[:material_id])
        byebug
        current_user.bookmark(@material) unless current_user.bookmarked?(@material) 
    end
end
