def get_total_net_income(_reports)
  total_net_income = 0
  reports.each do |report|
    gross_income = report.income - report.expense
    net_income = gross_income - report.tax.income_tax(gross_income)
    total_net_income += net_income
  end
  total_net_income
end
