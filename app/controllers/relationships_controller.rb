class RelationshipsController < ApplicationController

  def create
    @company = Company.find(params[:relationship][:followed_id])
    current_user.follow!(@company)
    
    respond_to do |format|
      format.html { redirect_to @company }
      format.js 
    end

  end

  def destroy
    @company = Relationship.find(params[:id]).followed
    current_user.unfollow!(@company)
    
    respond_to do |format|
      format.html { redirect_to @company }
      format.js 
    end
  end
end
