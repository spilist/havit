#encoding=utf-8

module GroupsHelper
  def is_full? (group)
    group.member_limit > 0 and group.characters.count >= group.member_limit
  end

  def joined_group? (group, user=current_user)
    not Character.in_group(user, group).blank?
  end

  def group_status (group)
    if joined_group?(group)
      'already-joined'
    elsif is_full?(group)
      'full-group'
    elsif group.password.present?
      'need-passcode'
    end
  end

  def notify_to_group (status, group=current_character.group)
    if not Rails.env.test?
      client ||= SendGrid::Client.new do |c|
        c.api_user = ENV['SENDGRID_USERNAME']
        c.api_key = ENV['SENDGRID_PASSWORD']
      end

      addresses = []
      group.characters.each do |cha|
        addresses << cha.user.email unless cha == current_character
      end

      addresses.each do |address|
        goal_str = "<strong>#{datestring status.verified_at} #{weekdaystring status.verified_at}의 실천 목표:</strong> <span style='color: #40BD9C; font-weight: normal;'>#{status.action_goal.description}</span>"
        mail = SendGrid::Mail.new do |m|
          m.to = address
          m.from = 'evermentors@gmail.com'
          m.subject = "[Havit] #{current_user.name}님이 '#{group.name}' 그룹에서 #{status.goal.theme} 실천을 하셨습니다."
          m.html ="
          <p style='position:relative; margin-top:0;'>
            <div style='display: inline-block; max-height: 31px; height: 31px; width: 31px; max-width: 31px; overflow: hidden;'>
              <img src='#{avatar_url(current_user)}' style='width: 31px; height: 31px;'>
            </div>
            <span style='display: inline-block; vertical-align: top; line-height: 31px; margin-top: 0; margin-left: 3px; padding-top: 0;'>#{current_user.name}</span>
          </p>
          <p style='margin:0; font-size:15px;'>#{goal_str}</p>
          <hr style='width: 30px; display: inline-block;'>
          <p style='white-space: pre-wrap; margin:0;'>#{auto_link(html_escape(status.description), html: {target: '_blank'}) do |text| truncate(text, length: 30) end}</p>
          <hr style='width: 30px; display: inline-block;'>
          <p style='font-size: small; margin-top:0;'>
            <a href=#{group_url(group) + '?status-id='+status.id.to_s}>Havit에서 보기</a>
          </p>"
        end
        client.send(mail)
      end
    end
  end
end

