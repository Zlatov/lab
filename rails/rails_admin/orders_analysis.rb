require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class OrdersAnalysis < RailsAdmin::Config::Actions::Base

        # register_instance_option :enabled? do
        #   bindings[:abstract_model].nil? || (
        #     (only.nil? || [only].flatten.collect(&:to_s).include?(bindings[:abstract_model].to_s)) &&
        #     ![except].flatten.collect(&:to_s).include?(bindings[:abstract_model].to_s) &&
        #     !bindings[:abstract_model].config.excluded?
        #   )
        # end

        # register_instance_option :visible? do
        #   authorized?
        # end

        register_instance_option :link_icon do
          'icon-eye-open'
        end

        register_instance_option :pjax? do
          false
        end

        # register_instance_option :sample_conf do
        #   nil # set a default value here
        # end

        # register_instance_option :another_sample_conf do
        #   nil # set a default value here
        # end

        # register_instance_option :member do
        #   true
        # end

        register_instance_option :collection do
          true
        end

        register_instance_option :controller do
          Proc.new do

            # Создать новый конфигурационный раздел:
            # module RailsAdmin
            #   module Config
            #     module Sections
            #       # Новый конфигурационный раздел
            #       class SampleSection < RailsAdmin::Config::Sections::Base
            #         register_instance_option :sample_conf do
            #           nil # set a default value here
            #         end
            # 
            # В настройках сконфигурировать если создали:
            # RailsAdmin.config do |config|
            #   config.model 'User' do
            #     sample_section do
            #       custom_method :some_value
            #       another_sample_conf do
            #         bindings[:object].do_something!
            #       end
            # 
            # Забрать конфигурацию, если создали:
            # model_config.sample_section.sample_conf

            respond_to do |format|
              format.html { render @action.template_name }
              format.js   { render @action.template_name, :layout => false }
            end
          end
        end
      end
    end
  end
end
