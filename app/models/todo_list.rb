class TodoList < ApplicationRecord
  has_many :todo_items

  def percent_complete
    return 0 if total_items == 0
     (100 * completed_items.to_f / total_items).round(1)
  end

  def completed_items
    @completed_items ||= todo_items.completed.count
  end

  def total_items
    @total_items ||= todo_items.count
  end

  def status
    case percent_complete.to_i
    when 0
      'Not started'
    when 100
      'Competed'
    else
      'In progress'
    end
  end
  def badge_color
    case percent_complete.to_i
    when 0
      'danger'
    when 100
      'success'
    else
      'primary'
    end
  end

  def total_expenditure
   @total_expenditure = todo_items.sum(:contri)
  end
  def ps_total
    @ps_total = todo_items.sum(:ps)
  end

  def individual_cost
     return 0 if total_items == 0
     ( (total_expenditure - ps_total) / total_items)
  end

  def raw(list)
    raw = []
    counter = 0
    list.todo_items.each do |item|
      raw << {
        :id => counter,
        :name => item.description,
        :contri => item.contri,
        :ps => item.ps,
        :ps_total => (individual_cost + item.ps)
      }
      counter += 1
    end
    p raw
    raw
  end

  def c_l(raw)
    credit = []
    lender = []
    raw.each do |item|
      if item[:contri] < individual_cost
        lender << {
          :id => item[:id],
          :name => item[:name],
          :contri => item[:contri],
          :ps => item[:ps],
          :ps_total => item[:ps_total],
          :lender => (item[:contri] - item[:ps_total])
        }
      else
        credit << {
          :id => item[:id],
          :name => item[:name],
          :contri => item[:contri],
          :ps => item[:ps],
          :ps_total => item[:ps_total],
          :credit => (item[:ps_total] - item[:contri])
        }
      end
    end
    p [credit, lender]
    return [credit, lender]
  end

  def trf(list)
    credit = c_l(raw(list))[0].sort_by! { |k| k[:contri]}
    lender = c_l(raw(list))[1].sort_by! { |k| k[:lender]}
    trf = []
    p credit
    p lender
  end

end
