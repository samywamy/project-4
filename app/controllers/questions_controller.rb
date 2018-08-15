class QuestionsController < ApplicationController
  before_action :authenticate_user!, :except => [ :show, :index ]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    if params.has_key?(:user_id)
        @username = User.where(id: params[:user_id]).first.email
        @questions = Question.where(user_id: params[:user_id])
        render :user_questions
    else
        @questions = Question.all
    end  
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new

  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.question_votes = 0
    @question.votes_answer_1 = 0
    @question.votes_answer_2 = 0

    respond_to do |format|
      if @question.save
        format.html { redirect_to profile_path, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question.question_votes = 0
    @question.votes_answer_1 = 0
    @question.votes_answer_2 = 0
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to profile_path, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to profile_path, notice: 'Question was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:answer_1, :answer_2, :votes_answer_1, :votes_answer_2, :question_votes, :user_id)
    end
end
