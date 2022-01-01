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
   @total_expenditure = todo_items.sum(:contri )
  end

  def individual_cost
     return 0 if total_items == 0
     ( total_expenditure.to_f / total_items).round(1)
  end

end
