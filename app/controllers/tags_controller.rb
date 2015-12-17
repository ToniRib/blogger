class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
  end

  def index
    @tags = Tag.all
  end

  def destroy
    Tag.find(params[:id]).destroy
    Tagging.where(tag_id: params[:id]).destroy_all

    flash.notice = "Tag Deleted!"

    redirect_to tags_path
  end
end
