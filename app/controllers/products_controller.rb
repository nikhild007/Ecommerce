class ProductsController < ApplicationController
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
        @product = Product.find(params[:id])
        @product.destroy!

        redirect_to controller: "home",action: "index"
    end

    def create
        # fileName = params[:article][:image].original_filename
        # params[:article][:image] = fileName
        @product = Product.new(product_params)
        if @product.save
            redirect_to controller: 'home', action: 'index'
        else
            render 'new'
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
