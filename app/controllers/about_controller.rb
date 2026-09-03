class AboutController < ApplicationController
  # thumbnail_url (used in the team member section) is defined in this
  # Spina helper, normally only auto-included in Spina-namespaced views.
  helper Spina::ImagesHelper

  load_and_authorize_resource :conference, find_by: :short_title
    
  def show
    
  end


end
