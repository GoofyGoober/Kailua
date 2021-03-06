class OutcomesController < ApplicationController
  before_action :set_outcome, only: [:show, :edit, :update, :destroy]

  # GET /outcomes
  def index
    @outcomes = Outcome.all.order('date_of_transaction ASC')
    @outcomes = Outcome.all.order("#{params[:sort]} #{params[:direction]}") if params[:sort].present?

    respond_to do |format|
      format.html
      format.csv { send_data @outcomes.to_csv, filename: 'uscite.csv' }
      format.xls { send_data @outcomes.to_csv(col_sep: "\t"), filename: 'uscite.xls'}
    end
  end

  # GET /outcomes/1
  def show
  end

  # GET /outcomes/new
  def new
    @outcome = Outcome.new
  end

  # GET /outcomes/1/edit
  def edit
  end

  # POST /outcomes
  def create
    @outcome = Outcome.new(outcome_params)

    if @outcome.save
      redirect_to outcomes_path, notice: 'Uscita creata.'
    else
      render :new
    end
  end

  # PATCH/PUT /outcomes/1
  def update
    if @outcome.update(outcome_params)
      redirect_to outcomes_path, notice: 'Uscita aggiornata.'
    else
      render :edit
    end
  end

  # DELETE /outcomes/1
  def destroy
    @outcome.destroy
    redirect_to outcomes_url, notice: 'Uscita cancellata.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outcome
      @outcome = Outcome.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def outcome_params
      params.require(:outcome).permit(:description, :date_of_transaction, :price, :category_id)
    end
end
