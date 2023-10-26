class ProductsController < ApplicationController
    include Pundit::Authorization

    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_product, only: %i[ show destroy ]


    def index
        @products = Product.all
        render 'home/index'
    end

    def show
        render 'product/show'
    end

    def destroy
        begin
            @product = Product.find(params[:id])
            authorize @product, :destroy?
            @product.destroy!

            redirect_to controller: "home",action: "index"
        rescue
            redirect_to controller: "home",action: "index"
        end
    end

    def create
        @product = Product.new(product_params)
        begin
            authorize @product, :create?
            if @product.save
                redirect_to controller: 'home', action: 'index'
            else
                render 'new'
            end
            flash[:notice] = "New Product added"
        rescue Exception => error
            @error = "Not Authorized to create product"
            flash[:error] = @error
            redirect_to controller: 'products', action: 'new'
        end
    end

    def new
        render 'product/new'
    end

    private
        def set_product
            @product = Product.find(params[:id])
        end

        def product_params
            params.permit(:name, :description, :price, :stock_quantity, :image)
        end
end
