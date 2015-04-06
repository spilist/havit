#encoding=utf-8

module ApplicationHelper
  def datestring (date=Time.current.to_date)
    date.strftime("%-m월 %-d일")
  end

  def weekdaystring (date=Time.current.to_date, option='long')
    # TODO: date.strftime("%a")와 i18n 활용
    case date.wday
      when 0
        wday = "일"
      when 1
        wday = "월"
      when 2
        wday = "화"
      when 3
        wday = "수"
      when 4
        wday = "목"
      when 5
        wday = "금"
      when 6
        wday = "토"
    end
    wday += "요일" if option == 'long'
    return wday
  end

  def seasonstring (date=season_start)
    date.strftime("%-Y년 %-m월 시즌")
  end

  def weekstring (date=Time.current.to_date)
    datestring(date.beginning_of_week) + '~' + datestring(date.beginning_of_week + 6.days)
  end

  def advanced_weekstring (date=last_weekly_goal.weeknum)
    "#{seasonstring date} #{relative_weeknum date}주차(#{weekstring date})"
  end
end
