class InstructorsController < ApplicationController
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordNotFound, with: :no_resource
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_student
    
    def index
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update(instructor_params)
        render json: instructor, status: :ok
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy
        render json: {}, status: :no_content
    end

    def create
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :created
    end

    def show
        instructor = Instructor.find(params[:id])
        render json: instructor, status: :ok
    end


    private

    def instructor_params
        params.permit(:name)
    end

    def no_resource
        render json: {errors: "No resource found"}, status: :not_found
    end

    def invalid_student(invalid)
        render json: {errors: invalid.record.errors.full_messages }, status: 422
    end


end
