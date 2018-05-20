module Service
  class OutcomesController < ServiceController
    def index
      @outcomes = Outcome.all
    end

    def show
      load_outcome
      redirect_to service_outcomes_path, alert: '見つかりません' unless @outcome
    end

    def new
      @outcome = Outcome.new
    end

    def edit
      load_outcome
      return redirect_to service_outcomes_path, alert: '見つかりません' unless @outcome
    end

    def create
      @outcome = Outcome.new(outcome_params)
      return render :new unless @outcome.save
      redirect_to service_outcomes_path, notice: '作成されました'
    end

    def update
      load_outcome
      return redirect_to service_outcomes_path, alert: '見つかりません' unless @outcome
      @outcome.attributes = outcome_params
      return render :edit unless @outcome.save
      redirect_to service_outcome_path(@outcome), notice: '更新されました'
    end

    def destroy
      load_outcome
      return redirect_to service_outcomes_path, alert: '見つかりません' unless @outcome
      @outcome.destroy
      redirect_to service_outcomes_url, notice: '削除されました'
    end

    private

    def load_outcome
      @outcome = Outcome.find_by(id: params[:id])
    end

    def outcome_params
      params.require(:outcome).permit(:name, :published)
    end
  end
end
