class ScientistsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :render_error
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        render json: Scientist.all, status: :ok
    end

    def show
        scientist = Scientist.find(params[:id])
        render json: scientist, status: :ok
    end

    def create
        new_scientist = Scientists.create!(scientist_params)
        if new_scientist
            render json: new_scientist, status: :created
        else
            render_unprocessable_entity
        end
    end

    def update
        update_scientist = Scientist.update!(scientist_params)
        if update_scientist
            render json: update_scientist, status: :accepted
        else
            render_unprocessable_entity
        end
    end

    def destroy
        delete_scientist = Scientist.find(params[:id])
        if delete_scientist
            delete_scientist.destroy
            head :no_content
        else
            render_error
        end
    end

    private

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def render_error
        render json: {error: 'Scientist not found'}, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
