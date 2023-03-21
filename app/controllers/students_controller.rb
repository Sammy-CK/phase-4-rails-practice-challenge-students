class StudentsController < ApplicationController
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordNotFound, with: :no_resource
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_student

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :ok
    end

    def destroy
        student = Student.find(params[:id])
        student.destroy
        render json: {}, status: :no_content
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def show
        student = Student.find(params[:id])
        render json: student, status: :ok
    end

    private

    def student_params
        params.permit(:name)
    end

    def no_resource
        render json: {errors: "No resource found"}, status: :not_found
    end

    def invalid_student(invalid)
        render json: {errors: invalid.record.errors.full_messages }, status: 422
    end

end
