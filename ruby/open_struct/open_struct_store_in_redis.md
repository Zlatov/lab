# Хранение данных для OpenStruct модели в Redis

```rb
# app/models/setting.rb
Setting = Struct.new(
  :application_name,
  :application_abbr
)

Setting.send(:include, SettingConcern)
```

```rb
module SettingConcern
  extend ActiveSupport::Concern

  included do
    include Admin::Translatable
    # Для рендеринга модели.
    include ActiveModel::Conversion
    # Для i18n модели.
    extend ActiveModel::Naming
    extend ActiveModel::Translation

    # include ActiveModel::Model
    # extend CarrierWave::Mount
    # mount_uploader :watermark, ProductWatermarkUploader

    def update(params)
      result = ::REDIS_POOL.with do |conn|
        conn.mapped_hmset :setting, params.to_h
      end
      return true if result == 'OK'
      false
    end

    def persisted?
      true
    end
  end

  class_methods do
    def find
      data = ::REDIS_POOL.with do |conn|
        conn.hgetall :setting
      end
      data.symbolize_keys!

      self.new(
        data[:application_name],
        data[:application_abbr]
      )
    end
  end
end
```

```rb
# app/controllers/admin/settings_controller.rb
class Admin::SettingsController < Admin::ApplicationController
  before_action :set_admin_setting, only: %i[ show edit update ]

  def show
  end

  def edit
  end

  def update
    if @admin_setting.update(admin_setting_params)
      redirect_to admin_setting_url, notice: @notice
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_admin_setting
    @admin_setting = Admin::Setting.find
  end

  def admin_setting_params
    params.require(:admin_setting).permit(
      :application_name,
      :application_abbr
    )
  end
end
```

```html
# app/views/admin/settings/_form.html.erb
<%= form_with(model: @admin_setting, scope: :admin_setting, url: admin_setting_path, method: :patch) do |form| %>

  <%#= form_errors(form) %>

  <div class="row mb-3">
    <div class="col">
      <b><%= form.label :application_name, class: 'form-label required' %></b>
      <%= field_info form.object, :application_name %>
      <%= form.text_field :application_name, class: 'form-control form-control-sm', required: true %>
      <%#= field_errors form.object, :application_name %>
    </div>
  </div>

  <div class="row mb-3">
    <div class="col">
      <b><%= form.label :application_abbr, class: 'form-label required' %></b>
      <%= field_info form.object, :application_abbr %>
      <%= form.text_field :application_abbr, class: 'form-control form-control-sm' %>
      <%#= field_errors form.object, :application_abbr %>
    </div>
  </div>

  <div class="row mb-3">
    <div class="col">
      <%= form.submit class: 'btn btn-primary btn-sm' %>
    </div>
  </div>
<% end %>
```
