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
          "data":[0,100,0],
          "fill": true
        },
        {
          "label":"Отправлен",
          "data":[1965,1905,1732],
          "fill": "-1"
        },
        {
          "label":"Отработан",
          "data":[399,513,664],
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
