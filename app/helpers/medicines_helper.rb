module MedicinesHelper
  def format_changes(object_changes, event_type)
    if object_changes.present?
      changes_hash = object_changes.deep_symbolize_keys
      changes_html = ""

      translations = {
        name: "Nome",
        unit: "Unidade",
        is_liquid: "É líquido?",
        quantity: "Quantidade",
        medicine_validity: "Validade",
        medicine_insert: "Bula",
        used_to: "Usado para",
        created_at: "Criado em",
        updated_at: "Atualizado em",
        user_id: "Usuário"
      }

      changes_hash.each do |attribute, values|
        translated_attribute = translations[attribute] || attribute.to_s.humanize
        before_value, after_value = values.map do |value|
          if value.is_a?(String)
            if value.match(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z/)
              Time.parse(value).strftime("%d/%m/%Y - %H:%M")
            elsif value.match(/\d{4}-\d{2}-\d{2}/)
              Date.parse(value).strftime("%d/%m/%Y")
            else
              value
            end
          else
            if attribute == :user_id
              User.find_by(id: value)&.name || value
            elsif attribute == :is_liquid
              value ? "Sim" : "Não"
            else
              value
            end
          end
        end
        
        changes_html += "<strong>#{translated_attribute}:</strong><br>"
        changes_html += "<ul class='list-none'>"
        changes_html += "<li class='flex items-center space-x-2'>"

        if event_type != "create"
          changes_html += "<span class='bg-red-500 text-white px-2 py-1 rounded'>#{before_value}</span>"
        end

        if event_type == "update"
          changes_html += "<span class='text-gray-500'>=&gt;</span>"
        end

        if event_type == "create"
          changes_html += "<span class='bg-blue-300 text-white px-2 py-1 rounded'>#{after_value}</span>"
        elsif event_type != "destroy"
          changes_html += "<span class='bg-green-500 text-white px-2 py-1 rounded'>#{after_value}</span>"
        end
        
        changes_html += "</li>"
        changes_html += "</ul>"
      end

      changes_html.html_safe

    else
      "Sem alterações registradas"
    end
  end

  def format_event_type(event_type)
    case event_type
    when "update"
      "<span class='text-green-600'>Atualização</span>".html_safe
    when "create"
      "<span class='text-blue-600'>Criação</span>".html_safe
    else
      "<span class='text-red-600'>Remoção</span>".html_safe
    end
  end
end
