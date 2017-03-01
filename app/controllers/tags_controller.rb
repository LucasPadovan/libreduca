class TagsController < ApplicationController
  before_action :authenticate_user!

  check_authorization
  load_and_authorize_resource through: :current_institution

  layout ->(controller) { controller.request.xhr? ? false : 'application' }

  # GET /tags
  # GET /tags.json
  def index
    @tags = @tags.filtered_list(params[:q]).where(
      tagger_type: params[:type]
    ).page(params[:page]).distinct('id')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end
end
