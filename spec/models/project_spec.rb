require "rails_helper"

RSpec.describe Project do
  describe "completion" do
    let(:project) {Project.new}
    let(:task) {Task.new}

    it "considers a projet with no tasks to be done" do
      expect(project).to be_done
    end

    it "knows that a project with an incomplete task is not done" do
      project.tasks << task
      expect(project).to_not be_done
    end

    it "marks a project done if its tasks are done" do
      project.tasks << task
      task.mark_completed
      expect(project).to be_done
    end
  end

  describe "estimate" do
    let(:project) { Project.new }
    let(:task_newly_done) { Task.new(size: 3, completed_at: 1.day.ago) }
    let(:task_old_done) { Task.new(size: 2, completed_at: 6.months.ago) }
    let(:task_small_not_done) { Task.new(size: 1) }
    let(:task_large_not_done) { Task.new(size: 4) }

    before(:example) do
      project.tasks = [ task_newly_done, task_old_done,  task_small_not_done, task_large_not_done ]
    end

    it "can calculate total size" do
      expect(project.completed_velocity).to eq(3)
    end

    it "knows its rate" do
      expect(project.current_rate).to eq(1.0 / 7)
    end
  end
end
