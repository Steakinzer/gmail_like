class EmailsController < ApplicationController
  def index
    @emails = Email.all
    @previews = Email.all
    @email = Email.new
  end

  def create
    @email = Email.new(sender: Faker::Internet.email, content: Faker::Lorem.sentence(word_count: 25))

    respond_to do |format|
      if @email.save
        format.html { redirect_to emails_url, notice: "Email a été envoyé" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @email = Email.find(params[:id])
  end

  def edit
    @email = Email.find(params[:id])
  end

  def update
    @email = Email.find(params[:id])
    respond_to do |format|
      if @email.update(sender: Faker::Internet.email, content: Faker::Lorem.sentence(word_count: 25))
        format.html { redirect_to emails_url, notice: "Task was successfully updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    redirect_to emails_url, notice: "Email supprimé."
  end

  private

  def task_params
    params.require(:email).permit(:content, :sender)
  end
end
