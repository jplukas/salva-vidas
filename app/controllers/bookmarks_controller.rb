class BookmarksController < ApplicationController
    def create
        @material = Material.find(params[:material_id])
        current_user.bookmark(@material) unless current_user.bookmarked?(@material) 
        respond_to do |format|
            format.html{redirect_to @material}
            format.js
        end
    end

    def destroy
        @material = Bookmark.find(params[:id]).material
        current_user.un_bookmark(@material) if current_user.bookmarked?(@material) 
        respond_to do |format|
            format.html{redirect_to @material}
            format.js
        end
    end
end
