module DashboardHelper
  def show_teach_info(teach)
    content = content_tag(
      :ul, [
        content_tag(
          :li, [
            content_tag(:strong, Teach.human_attribute_name('start')),
            l(teach.start, format: :long)
          ].join(' ').html_safe
        ),
        content_tag(
          :li, [
            content_tag(:strong, Teach.human_attribute_name('finish')),
            l(teach.finish, format: :long)
          ].join(' ').html_safe
        )
      ].join('')
    )

    show_info title: Teach.model_name.human, content: content
  end

  def show_dashboard_score(score)
    classes = ['badge']
    classes << 'badge-success' if score >= SCORE_SUCCESS_THRESHOLD
    classes << 'badge-warning' if score <= SCORE_FAIL_THRESHOLD

    content_tag(
      :span, number_with_precision(score), class: classes.join(' ')
    )
  end

  def show_dashboard_score_extras(score)
    content = content_tag(
      :ul, [
        content_tag(
          :li, [
            content_tag(:strong, Score.human_attribute_name('multiplier')),
            number_with_precision(score.multiplier)
          ].join(' ').html_safe
        ),
        content_tag(
          :li, [
            content_tag(:strong, Score.human_attribute_name('created_at')),
            l(score.created_at, format: :long)
          ].join(' ').html_safe
        ),
        content_tag(
          :li, [
            content_tag(:strong, Score.human_attribute_name('whodunnit')),
            (User.find(score.originator) rescue '-')
          ].join(' ').html_safe
        )
      ].join('').html_safe
    )

    show_info title: score.description, content: content
  end

  def show_info(options = {})
    content_tag(
      :span, nil,
      title: options[:title],
      class: 'text-muted small glyphicon glyphicon-info-sign pull-right',
      data: {
        show_popover: true,
        content: raw(options[:content]),
        placement: options[:placement] || 'left'
      }
    )
  end
end
