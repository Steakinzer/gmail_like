class EmailsController < ApplicationController
  def index
    @emails = Email.all
    @email = Email.new
  end

  def create
    @email = Email.new(sender: Faker::Internet.email, content:Faker::Lorem.sentence)

    respond_to do |format|
      if @email.save
        format.html { redirect_to emails_url, notice: "Email a été envoyé" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @email = Email.find(params[:id])
  end

  def update
    @email = Email.find(params[:id])
    respond_to do |format|
      if @email.update(sender: Faker::Internet.email, content:Faker::Lorem.sentence)
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
