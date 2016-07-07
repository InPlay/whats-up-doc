class DocsController < ApplicationController
  before_action :set_doc, only: [:show, :edit, :update, :destroy]

  # GET /docs
  # GET /docs.json
  def index
    @docs = Doc.all
  end

  # GET /docs/1
  # GET /docs/1.json
  def show
    @doc = @doc.becomes(Doc::AddingItem)
  end

  # GET /docs/new
  def new
    @doc = Doc.new
    @doc = @doc.becomes(Doc::AddingItem)
  end

  # GET /docs/1/edit
  def edit
  end

  # POST /docs
  # POST /docs.json
  def create
    @doc = Doc.new(doc_params)
    @doc = @doc.becomes(Doc::Creating)

    respond_to do |format|
      if @doc.save
        format.html { redirect_to @doc, notice: 'Doc was successfully created.' }
        format.json { render :show, status: :created, location: @doc }
      else
        format.html { render :new }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /docs/1
  # PATCH/PUT /docs/1.json
  def update
    respond_to do |format|
      @doc = @doc.becomes(Doc::AddingItem)
      if @doc.update(doc_params)
        ActionCable.server.broadcast "docs-#{@doc.slug}",
          items: ApplicationController.render(
            @doc.items),
          impact_list: ApplicationController.render(
            @doc.impact_list,
            locals: {doc: @doc, list_type: :impact_list}),
          implementation_list: ApplicationController.render(
            @doc.implementation_list,
            locals: {doc: @doc, list_type: :implementation_list}),
          chart: ApplicationController.render(
            partial: "docs/chart",
            locals: {doc: @doc})

        format.html { head status: :ok, location: @doc }
        format.json { render :show, status: :ok, location: @doc }
      else
        format.html { render :edit }
        format.json { render json: @doc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docs/1
  # DELETE /docs/1.json
  def destroy
    @doc.destroy
    respond_to do |format|
      format.html { redirect_to docs_url, notice: 'Doc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doc
      @doc = Doc.find_by_slug(params[:slug])
      @page_title = @doc&.title
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doc_params
      params.require(:doc).permit(
        :title,
        add_item: [:content],
        impact_list_attributes: [
          :id,
          {positions_attributes: [:position, :id]}
        ],
        implementation_list_attributes: [
          :id,
          {positions_attributes: [:position, :id]}
        ]
      )
    end
end
