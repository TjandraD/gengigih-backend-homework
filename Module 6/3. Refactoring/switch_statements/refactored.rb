class Tax
  def income_tax(gross_income)
    raise NotImplementedError
  end
end

class IndividualTax < Tax
  def income_tax(gross_income)
    gross_income * 0.1
  end
end

class EnterpriseTax < Tax
  def income_tax(gross_income)
    gross_income * 0.2
  end
end

class GovernmentTax < Tax
  def income_tax(gross_income)
    gross_income * 0.05
  end
end

class BasicTax < Tax
  def income_tax(gross_income)
    gross_income * 0.3
  end
end
