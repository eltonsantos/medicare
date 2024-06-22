module MedicinesHelper
  def format_changes(object_changes)
    if object_changes.present?
      changes_hash = if object_changes.is_a?(String)
                       JSON.parse(object_changes).deep_symbolize_keys
                     else
                       object_changes.deep_symbolize_keys
                     end

      changes_html = ""

      changes_hash.each do |attribute, values|
        before_value, after_value = values
        changes_html += "<strong>#{attribute}:</strong><br>"
        changes_html += "<ul class='list-none'>"
        changes_html += "<li class='flex items-center space-x-2'>"
        changes_html += "<span class='bg-red-500 text-white px-2 py-1 rounded'>#{before_value}</span>"
        changes_html += "<span class='text-gray-500'>=&gt;</span>"
        changes_html += "<span class='bg-green-500 text-white px-2 py-1 rounded'>#{after_value}</span>"
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
