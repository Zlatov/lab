class Mailer::FromSite < ApplicationMailer

  # рендерит write_to_leader.html.erb
  def write_to_leader form_model
    # Переменные для рендера шаблона письма
    @form_model = form_model
    @time_now = Time.now.strftime("%Y-%m-%d %H:%M:%S")

    # Прикрепляем файл
    if @management_letter.file.present?
      attachments[@management_letter.file.filename] = File.read(@management_letter.file.path)
    end

    # Заполняем реквизиты письма
    mail \
      to: ,
      from: ,
      subject: ,
      reply_to: 
    # С указанием формата:
    mail(
      to: ZENOMAIL,
      cc: phil_email,
      reply_to: order_model["email"],
      subject: @subject
    ) do |format|
      format.html { render layout: 'mailer/from_site' }
      # format.text
    end
  end
end
