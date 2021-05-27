require "active_record"

class Todo < ActiveRecord::Base

  # def self.overdue
  #   where("due_date < ?", Date.today).map { |todo| todo })
  # end

  def due_today?
    due_date == Date.today
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue\n"
    puts where("due_date <  ?", Date.today).to_displayable_list
    puts "\n\n"

    puts "Due Today\n"
    puts where("due_date = ?", Date.today).to_displayable_list
    puts "\n\n"

    puts "Due Later\n"
    puts where("due_date > ?", Date.today).to_displayable_list
    puts "\n\n"
  end

  def self.add_task(a)
    create!(todo_text: a[:todo_text], due_date: Date.today + a[:due_in_days], completed: false)
  end

  def self.mark_as_complete(id)
    done = find(id)
    done.completed = true
    done
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id} #{display_status} #{todo_text} #{display_date}"
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end
end
