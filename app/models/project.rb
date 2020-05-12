class Project

  attr_accessor :tasks

  def initialize
    @tasks = []
  end

  def incomplete_tasks
    tasks.reject(&:complete?)
  end

  def complete_tasks
    tasks.select(&:complete?)
  end

  def done?
    incomplete_tasks.empty?
  end

  def total_size
    tasks.sum(&:size)
  end

  def remaining_size
    incomplete_tasks.sum(&:size)
  end

  def completed_velocity
    complete_tasks.sum(&:points_toward_velocity)
  end

end
