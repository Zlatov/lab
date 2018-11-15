exit

params.permit(:from, :to_free, :subject, :content)

# Вложенные параметры вынуть и разрешить так:
params
  .require(:management_letter)
  .permit(:name, :email, :message, :phonenumber, :file)
