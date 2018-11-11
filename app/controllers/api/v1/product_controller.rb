module Api
	module V1
		class ProductController < ApplicationController
			def index
				products = Product.all
				send_ok_response(products)
			end

			def show
				product = Product.find(params[:id])
				send_ok_response(product)

			end

			def create
				product = Product.create(params.permit(:name, :description, :quantity, :price))
				if(product.save)
					send_ok_response(product)
				else
					send_error_response(product.errors)
				end
			end

			def update
				product = Product.find(params[:id])
				if product.update(params.permit(:name, :description, :quantity, :price))
					send_ok_response(product)
				else
					send_error_response(product.errros)
				end
			end

			def destroy
				product = Product.find(params[:id])
				product.destroy()
				send_ok_response(product)
			end

			def send_ok_response(records)
				render json: { status: 'SUCCESS', data:records }, status: :ok
			end

			def send_error_response(error)
				render json: { status: 'ERROR', data:error }, status: :unprocessable_entity
			end
		end
	end
end