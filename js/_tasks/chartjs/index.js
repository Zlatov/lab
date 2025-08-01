$(document).ready(function() {
  activate_chart()
})

function activate_chart() {
  const ctx = document.getElementById('ordersChart').getContext('2d')
  const chart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: ["2018","2019","2020"],
      datasets: [
        {
          "label":"Ожидает",
          "data":[100,145,55],
          "fill": true
        },
        {
          "label":"Отправлен",
          "data":[100,55,145],
          "fill": "-1"
        },
        {
          "label":"Отработан",
          "data":[100,145,55],
          "fill": "-1"
        },
        {
          "label":"Отработан",
          "data":[100,55,145],
          "fill": "-1"
        },
        {
          "label":"Ожидает",
          "data":[100,145,55],
          "fill": "-1"
        },
        {
          "label":"Отправлен",
          "data":[100,55,145],
          "fill": "-1"
        },
        {
          "label":"Отработан",
          "data":[100,145,55],
          "fill": "-1"
        },
        {
          "label":"Отработан",
          "data":[100,55,145],
          "fill": "-1"
        },
        {
          "label":"Отправлен",
          "data":[100,55,145],
          "fill": "-1"
        },
        {
          "label":"Отработан",
          "data":[100,145,55],
          "fill": "-1"
        },
        {
          "label":"Отработан",
          "data":[100,55,145],
          "fill": "-1"
        },
      ]
    },
    options: {
      responsive: true,
      scales: {
        y: {
          stacked: true
        }
      },
      interaction: {
        intersect: false,
        mode: 'index'
      },
      plugins: {
        legend: {
          position: 'top'
        },
        tooltip: {
          mode: 'index',
          intersect: false
        }
      }
    }
  })
}
