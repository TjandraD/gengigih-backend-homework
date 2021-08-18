def get_total_net_income(_reports)
  total_net_income = 0

  reports.each do |report|
    gross_income = get_gross_income(report)
    net_income = get_net_income(report, gross_income)
    total_net_income += net_income
  end

  total_net_income
end

def get_gross_income(report)
  report.income - report.expense
end

def get_net_income(report, gross_income)
    gross_income -  report.tax.income_tax(gross_income)
end
