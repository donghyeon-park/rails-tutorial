class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show 
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def product_params
      # 해당 코드는 6.1.5.1 버전에서 사용되지 않음
      # params.expect(product: [ :name ])
      params.require(:product).permit(:name)
    end
end