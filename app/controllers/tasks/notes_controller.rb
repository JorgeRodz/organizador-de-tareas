# frozen_string_literal: true

#          👇 "Scope resolution operator"
class Tasks::NotesController < ApplicationController
  #   👆   "Namespacing"  👆
  before_action :set_task

  def create
    @note = @task.notes.new(note_params) # create a new note instance for the task
    @note.user = current_user # set current user as the note user
    @note.save
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end

  def set_task
    @task = Task.find(params[:task_id])
  end
end
