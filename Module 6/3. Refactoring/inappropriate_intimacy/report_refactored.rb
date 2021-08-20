class Report
  def initialize(income, expense, type, date)
    @income = income
    @expense = expense
    @type = Tax.new(type)
    @date = date
  end

  def income_tax
    @tax.income_tax(@income)
  end
end

## client code
income_tax = report.income_tax
