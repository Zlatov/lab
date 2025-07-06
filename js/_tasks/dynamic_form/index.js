$(document).ready(function() {
  DynamicForm.init()
})

const DynamicForm = {
  place: null,
  samples: null,
  tune: null,
  data: null,
  data_sample: {
    header: {
      type: "header",
      value: "Запись на конференцию",
    },
    text: {
      type: "text",
      value: "Пользователям отправивших заявку предоставляются VIP места",
    },
    input: {
      type: "input",
      label: "ФИО полностью",
    },
    textarea: {
      type: "textarea",
      label: "Комментарий",
    },
    select: {
      type: "select",
      label: "Тип компании",
      prompt: "Выберите",
      options: [
        "Малый бизнес",
        "Средний бизнес",
        "Крупная компания",
        "Стартап",
        "Самозанятый / Фрилансер"
      ]
    },
    checkbox: {
      type: "checkbox",
      label: "Буду присутствовать на семинаре после конференции",
    },
    checkboxes: {
      type: "checkboxes",
      label: "Удобное время посещения",
      options: [
        "Утро (9:00–12:00)",
        "День (12:00–17:00)",
        "Вечер (17:00–20:00)",
        "Готов обсудить индивидуально"
      ]
    },
    radio: {
      type: "radio",
      label: "Ваша должность",
      options: [
        "Руководитель",
        "Маркетолог",
        "HR-специалист",
        "Финансист",
        "Специалист другого профиля"
      ]
    }
  },

  init() {
    if ($(".dynamic_form").length != 1) {
      return false
    }

    this.place = $(".dynamic_form")
    this.samples = this.place.find(".dynamic_form-samples")
    this.tune = this.place.find(".dynamic_form-tune")
    this.view = this.place.find(".dynamic_form-view")
    this.review_timeout_id = null
    this.data = this.place.data("form_data")
    this.activate_ui()
    this.render()
  },

  activate_ui() {
    this.place.on("click", ".dynamic_form-add", this.add.bind(this))
    this.place.on("click", ".dynamic_form-tune .dynamic_form-remove", this.remove.bind(this))
    this.place.on("click", ".dynamic_form-tune .dynamic_form-option_remove", this.option_remove.bind(this))
    this.place.on("click", ".dynamic_form-tune .dynamic_form-option_add", this.option_add.bind(this))
    this.place.on("keyup", ".dynamic_form-tune input", this.input_save_to_data.bind(this))
    this.place.on("keyup", ".dynamic_form-tune textarea", this.textarea_save_to_data.bind(this))
  },

  add(event) {
    var button = $(event.currentTarget)
    var type = button.data("type")
    this.data.push(JSON.parse(JSON.stringify(this.data_sample[type])))
    this.render()
  },

  option_add(event) {
    var button = $(event.currentTarget)
    var field = button.closest(".dynamic_form-field")
    var index = this.tune.find(".dynamic_form-field").index(field)
    this.data[index].options.push("")
    this.render()
  },

  // Удаление поля из данных / перерендер
  remove(event) {
    var button = $(event.currentTarget)
    var field = button.closest(".dynamic_form-field")
    var index = this.tune.find(".dynamic_form-field").index(field)
    if (index !== -1) {
      this.data.splice(index, 1)
      this.render()
    }
  },

  // Удаление данных опии из поля / перерендер
  option_remove(event) {
    var button = $(event.currentTarget)
    var option = button.closest(".dynamic_form-option")
    var options = button.closest(".dynamic_form-options")
    var option_index = options.find(".dynamic_form-option").index(option)
    var field = button.closest(".dynamic_form-field")
    var index = this.tune.find(".dynamic_form-field").index(field)
    if (index !== -1 && option_index !== -1) {
      this.data[index].options.splice(option_index, 1)
      this.render()
    }
  },

  input_save_to_data(event) {
    var input = $(event.currentTarget)
    var field = input.closest(".dynamic_form-field")
    var index = this.tune.find(".dynamic_form-field").index(field)

    if (index === -1) return

    var name = input.attr("name")
    var value = input.val()

    if (name === "option") {
      // для массива options
      var option_wrapper = input.closest(".dynamic_form-options")
      var option_index = option_wrapper.find("input[name='option']").index(input)
      if (option_index !== -1) {
        this.data[index].options[option_index] = value
      }
    } else {
      this.data[index][name] = value
    }

    // Отложенный вызов для отрисовки UI без скачков.
    if (this.review_timeout_id != null) {
      clearTimeout(this.review_timeout_id)
    }
    this.review_timeout_id = setTimeout(() => {
      this.review()
    }, 300)
  },

  textarea_save_to_data(event) {
    var textarea = $(event.currentTarget)
    var field = textarea.closest(".dynamic_form-field")
    var index = this.tune.find(".dynamic_form-field").index(field)

    if (index === -1) return

    var name = textarea.attr("name")
    var value = textarea.val()

    this.data[index][name] = value

    // Отложенный вызов для отрисовки UI без скачков.
    if (this.review_timeout_id != null) {
      clearTimeout(this.review_timeout_id)
    }
    this.review_timeout_id = setTimeout(() => {
      this.review()
    }, 300)
  },

  render() {
    this.tune.empty()
    console.log('this.data: ', this.data)
    this.data.forEach((e, i, a) => {
      this[`render_${e.type}`](e, i)
    })
    this.review()
  },

  render_header(data, index) {
    var template = this.samples.find(".dynamic_form-header").clone()
    template.find(".dynamic_form-num").text(index + 1)
    template.find("input[name='value']").val(data.value)
    this.tune.append(template)
  },

  render_text(data, index) {
    var template = this.samples.find(".dynamic_form-text").clone()
    template.find(".dynamic_form-num").text(index + 1)
    template.find("textarea[name='value']").val(data.value)
    this.tune.append(template)
  },

  render_input(data, index) {
    var template = this.samples.find(".dynamic_form-input").clone()
    template.find(".dynamic_form-num").text(index + 1)
    template.find("input[name='label']").val(data.label)
    this.tune.append(template)
  },

  render_textarea(data, index) {
    var template = this.samples.find(".dynamic_form-textarea").clone()
    template.find(".dynamic_form-num").text(index + 1)
    template.find("input[name='label']").val(data.label)
    this.tune.append(template)
  },

  render_select(data, index) {
    var template = this.samples.find(".dynamic_form-select").clone()
    template.find(".dynamic_form-num").text(index + 1)
    template.find("input[name='label']").val(data.label)
    template.find("input[name='prompt']").val(data.prompt)
    var option_template = template.find(".dynamic_form-option").clone()
    template.find(".dynamic_form-option").remove()
    data.options.forEach((e, i, a) => {
      var option = option_template.clone()
      option.find("input[name='option']").val(e)
      template.find(".dynamic_form-options").append(option)
    })
    this.tune.append(template)
  },

  render_checkbox(data, index) {
    var template = this.samples.find(".dynamic_form-checkbox").clone()
    template.find(".dynamic_form-num").text(index + 1)
    template.find("input[name='label']").val(data.label)
    this.tune.append(template)
  },

  render_checkboxes(data, index) {
    var template = this.samples.find(".dynamic_form-checkboxes").clone()
    template.find(".dynamic_form-num").text(index + 1)
    template.find("input[name='label']").val(data.label)
    var option_template = template.find(".dynamic_form-option").clone()
    template.find(".dynamic_form-option").remove()
    data.options.forEach((e, i, a) => {
      var option = option_template.clone()
      option.find("input[name='option']").val(e)
      template.find(".dynamic_form-options").append(option)
    })
    this.tune.append(template)
  },

  render_radio(data, index) {
    var template = this.samples.find(".dynamic_form-radio").clone()
    template.find(".dynamic_form-num").text(index + 1)
    template.find("input[name='label']").val(data.label)
    var option_template = template.find(".dynamic_form-option").clone()
    template.find(".dynamic_form-option").remove()
    data.options.forEach((e, i, a) => {
      var option = option_template.clone()
      option.find("input[name='option']").val(e)
      template.find(".dynamic_form-options").append(option)
    })
    this.tune.append(template)
  },

  review() {
    this.view.empty()

    this.data.forEach((field, index) => {
      let element

      switch (field.type) {
        case "header":
          element = $(`<h4 class="mb-3">${field.value}</h4>`)
          break

        case "text":
          element = $(`<p class="mb-3">${field.value}</p>`)
          break

        case "input":
          element = $(`
            <div class="form-group mb-3">
              <label>${field.label}</label>
              <input type="text" class="form-control" placeholder="">
            </div>
          `)
          break

        case "textarea":
          element = $(`
            <div class="form-group mb-3">
              <label>${field.label}</label>
              <textarea class="form-control" rows="3"></textarea>
            </div>
          `)
          break

        case "select":
          const options = (field.options || [])
            .map(o => `<option>${o}</option>`)
            .join("")
          element = $(`
            <div class="form-group mb-3">
              <label>${field.label}</label>
              <select class="form-control">
                <option disabled selected>${field.prompt || "Выберите"}</option>
                ${options}
              </select>
            </div>
          `)
          break

        case "checkbox":
          element = $(`
            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" id="checkbox_${index}">
              <label class="form-check-label" for="checkbox_${index}">
                ${field.label}
              </label>
            </div>
          `)
          break

        case "checkboxes":
          const checkboxes = (field.options || [])
            .map((opt, i) => `
              <div class="form-check">
                <input class="form-check-input" type="checkbox" id="checkboxes_${index}_${i}">
                <label class="form-check-label" for="checkboxes_${index}_${i}">
                  ${opt}
                </label>
              </div>
            `)
            .join("")
          element = $(`
            <div class="mb-3">
              <label class="form-label d-block">${field.label}</label>
              ${checkboxes}
            </div>
          `)
          break

        case "radio":
          const radios = (field.options || [])
            .map((opt, i) => `
              <div class="form-check">
                <input class="form-check-input" type="radio" name="radio_${index}" id="radio_${index}_${i}">
                <label class="form-check-label" for="radio_${index}_${i}">
                  ${opt}
                </label>
              </div>
            `)
            .join("")
          element = $(`
            <div class="mb-3">
              <label class="form-label d-block">${field.label}</label>
              ${radios}
            </div>
          `)
          break

        default:
          element = $(`<div class="mb-3 text-muted">[Неизвестный тип: ${field.type}]</div>`)
      }

      this.view.append(element)
    })
  }
}
