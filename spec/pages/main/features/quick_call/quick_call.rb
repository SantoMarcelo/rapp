require_relative '../../../../sections/main/features/quick_call'

class QuickCall < Home

  section :recent_calls, Sections::QuickCall, '.appMain'
  section :dial_pad, Sections::QuickCall, '.dialpad__container'

  element :confirm_mark_as_read, '.noty_body'

  def type_number_to_dial(number)
    number_to_dial = number.to_s.split(//)
    number_to_dial.each do |n|
      dial_pad.dial_pad_numbers.each do |u|
        u.click if u.text.include?(n)
      end
    end
  end
  
  def eraser_data
    number = dial_pad.txt_phone_dial.value.to_s
    i = 0
    while i < number.length
      dial_pad.btn_eraser.click
      i += 1
    end
  end

  def validate_call_list(user, call_type)
    recent_calls.call_list.each do |u|
      if u.text.include?(user[:name]) && u.text.include?(user[:phone1]) || u.text.include?(user[:phone2])
        if u.has_css?("i[class*=\"#{call_type}\"]")
          return true
        end
      end
    end
    return false
  end

  def mark_as_read(user, call_type)
    i = 0
    recent_calls.call_list.each do |u|
      if u.text.include?(user[:name]) && u.text.include?(user[:phone]) || u.text.include?(user[:phone2])
        if u.has_css?("i[class*=\"#{call_type}\"]")
          recent_calls.mark_as_read[i].click
        end
      end
      i += 1
    end
  end

  def check_mark_as_read (user, call_type)
    recent_calls.call_list.each do |u|
      if u.text.include?(user[:name]) && u.text.include?(user[:phone]) || u.text.include?(user[:phone2])
        if u.has_css?("i[class*=\"#{call_type}\"]")
          if u.has_css?('i.call__action_mark_as_read.is-invisible')
            return true
          end
        end
      end
      return false
    end
  end

  def do_call(user, call_type)
    i = 0
    recent_calls.call_list.each do |u|
      if u.text.include?(user[:name]) && u.text.include?(user[:phone]) || u.text.include?(user[:phone2])
        if u.has_css?("i[class*=\"#{call_type}\"]")
          recent_calls.call_icon[i].click
        end
      end
      i += 1
    end
  end
end
