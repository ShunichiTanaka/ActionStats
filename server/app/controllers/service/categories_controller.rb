module Service
  class CategoriesController < ServiceController
    def index
      @categories = Category.all
    end

    def show
      load_category
      redirect_to service_categories_path, alert: '見つかりません' unless @category
    end

    def new
      @category = Category.new
    end

    def edit
      load_category
      redirect_to service_categories_path, alert: '見つかりません' unless @category
    end

    def create
      @category = Category.new(category_params)
      return render :new unless @category.save
      redirect_to service_categories_path, notice: '作成されました'
    end

    def update
      load_category
      return redirect_to service_categories_path, alert: '見つかりません' unless @category
      @category.attributes = category_params
      return render :edit unless @category.save
      redirect_to service_category_path(@category), notice: '更新されました'
    end

    def destroy
      load_category
      return redirect_to service_categories_path, alert: '見つかりません' unless @category
      @category.destroy
      redirect_to service_categories_path, notice: '削除されました'
    end

    private

    def load_category
      @category = Category.find_by(id: params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
