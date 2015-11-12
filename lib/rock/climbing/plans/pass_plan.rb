class PassPlan
  attr_reader :start_date

  def initialize(start_date)
    @start_date = start_date
  end

  def gym_name
    raise NotImplementedError
  end

  def price
    raise NotImplementedError
  end

  def plan_days
    raise NotImplementedError
  end

  def individual_rate
    raise NotImplementedError
  end

  def session_covered?(climbing_session)
    date = climbing_session.date
    is_after_start_date?(date) && is_before_end_date?(date) && gym_name == climbing_session.gym_name
  end

  private
  def is_after_start_date?(date)
    date - self.start_date >= 0
  end

  def is_before_end_date?(date)
    end_date = @start_date + (plan_days * seconds_per_day)
    date - end_date <= 0
  end

  def seconds_per_day
    86400
  end
end
