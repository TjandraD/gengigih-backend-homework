def average_income_in(date_range)
  ## Truncated code
  total_days = date_range.get_number_of_days
  total_income / total_days
end

class DateRange
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def get_number_of_days
    (@end_date - @start_date).to_i
  end
end
