class ProductsController < ApplicationController
    include Pundit::Authorization

    before_action :authenticate_user!, except: [:show]
    before_action :set_product, only: %i[ show destroy ]


    def index
        authorize current_user, :isAdmin?
        respond_to do |format|
            format.html
            format.json { render json: ProductDatatable.new(params) }
        end
    end

    def show
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
        authorize @product, :create?
        if @product.save
            flash[:notice] = "New Product added"
            redirect_to controller: 'home', action: 'index'
        else
            render 'new'
        end
    end

    def new
    end

    private
        def set_product
            @product = Product.find(params[:id])
        end

        def product_params
            params.permit(:name, :description, :price, :stock_quantity, :image)
        end
end
