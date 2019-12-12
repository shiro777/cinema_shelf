$ ->
  $('#checkbox_parent_field').on 'click', ->
    checkbox =  $('input[type=checkbox')
    checkbox_status =  checkbox.prop('checked')
    if checkbox_status
      checkbox.prop('checked', false)
    else
      checkbox.prop('checked', true)
