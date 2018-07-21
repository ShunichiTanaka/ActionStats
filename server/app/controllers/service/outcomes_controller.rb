module Service
  class OutcomesController < ServiceController
    def index
      @outcomes = Outcome.all.order(:display_order, :category_id)
    end

    def show
      load_outcome
      redirect_to service_outcomes_path, alert: '見つかりません' unless @outcome
    end

    def new
      load_categories_selection
      @outcome = Outcome.new
    end

    def edit
      load_categories_selection
      load_outcome
      redirect_to service_outcomes_path, alert: '見つかりません' unless @outcome
    end

    def create
      @outcome = Outcome.new(outcome_params)
      unless @outcome.save
        load_categories_selection
        return render :new
      end
      redirect_to service_outcomes_path, notice: '作成されました'
    end

    def update
      load_outcome
      return redirect_to service_outcomes_path, alert: '見つかりません' unless @outcome
      @outcome.attributes = outcome_params
      unless @outcome.save
        load_categories_selection
        return render :edit
      end
      redirect_to service_outcome_path(@outcome), notice: '更新されました'
    end

    def destroy
      load_outcome
      return redirect_to service_outcomes_path, alert: '見つかりません' unless @outcome
      return redirect_to service_outcomes_path, alert: '公開中の「何した」は削除できません' if @outcome.published
      @outcome.destroy
      redirect_to service_outcomes_url, notice: '削除されました'
    end

    def publish_all
      return redirect_to service_outcomes_path, alert: 'チェックを入れてください' unless params[:publish]
      checked_data = params[:publish].keys
      checked_data.each(&method(:publish_outcome))
      redirect_to service_outcomes_path, notice: after_published_message
    end

    private

    def load_outcome
      @outcome = Outcome.find_by(id: params[:id])
    end

    def outcome_params
      params.require(:outcome).permit(:category_id, :name, :published, :display_order, :r_value, :g_value, :b_value)
    end

    def load_categories_selection
      @categories_selection = Category.pluck(:name, :id)
    end

    def publish_outcome(outcome_id)
      outcome = Outcome.find_by(id: outcome_id)
      return unless outcome
      outcome.update published: params[:unpublish].blank?
    end

    def after_published_message
      params[:unpublish].blank? ? '一括公開しました' : '一括非公開しました'
    end
  end
end
