class Notifier < ActionMailer::Base
  layout 'notifier_mailer'
  helper :application
  default from: "'#{I18n.t('app_name')}' <#{APP_CONFIG['smtp']['user_name']}>"
  
  def enrollment_status(enrollment)
    @enrollment = enrollment
    @users = [enrollment.user] + enrollment.user.relatives.to_a
    
    mail(
      subject: t(
        'notifier.enrollment_status.subject',
        user: @enrollment.user,
        course: @enrollment.course
      ),
      to: enrollment.user.email,
      cc: enrollment.user.relatives.map(&:email)
    )
  end

  def new_forum(forum)
    @forum = forum
    @users = forum.users

    mail(
      subject: t('notifier.new_forum.subject', forum: @forum),
      bcc: @users.map(&:email)
    )
  end
end
