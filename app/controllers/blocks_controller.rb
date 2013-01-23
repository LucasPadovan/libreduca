class BlocksController < ApplicationController
  layout ->(controller) { controller.request.xhr? ? false : 'application' }

  before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource :page

  before_filter :set_blockable

  load_and_authorize_resource through: :blockable

  def new
    @title = t('view.blocks.new_title')

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @forum }
    end
  end

  # POST /blocks
  # POST /blocks.json
  def create
    @title = t('view.blocks.new_title')

    respond_to do |format|
      if @block.save
        format.html { redirect_to root_url }
        format.js
        format.json { head :ok }
      else
        format.js
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @title = t('view.blocks.show_title')

    respond_to do |format|
      format.html { render partial: 'block' }
      format.json { head :ok }
      format.js
    end
  end

  # GET /blocks/1/edit
  def edit
    @title = t('view.blocks.edit_title')

    respond_to do |format|
      format.html
      format.js
    end
  end

  # PUT /blocks/1
  # PUT /blocks/1.json
  def update
    @title = t('view.blocks.edit_title')

    respond_to do |format|
      if @block.update_attributes(params[:block])
        format.html
        format.js
        format.json { head :ok }
      else
        format.js
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_polymorphic_url([@blockable, @block]), alert: t('view.blocks.stale_object_error')
  end

  # DELETE /blocks/1
  # DELETE /blocks/1.json
  def destroy
    @block.destroy

    respond_to do |format|
      format.html { head :ok, notice: t('view.blocks.destroy') }
      format.js
      format.json { head :ok }
    end
  end

  # POST /pages/1/sort
  # POST /pages/1/sort.json
  def sort
    params[:block].each_with_index do |id, index|
      @blockable.blocks.find(id).update_attributes!(position: index + 1)
    end

    respond_to do |format|
      format.html { head :ok, notice: t('view.blocks.sorted') }
      format.json { head :ok }
    end
  end

  def set_blockable
    @blockable = @page
  end
end
