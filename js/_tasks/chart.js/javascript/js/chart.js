"use strict"

import Chart from 'chart.js/auto';

window.chart = {}
window.chart.activate = function() {
  var ctx = document.getElementById('myChart').getContext('2d');
  var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
      datasets: [{
        label: '# of Votes',
        data: [12, 19, 3, 5, 2, 3],
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(255, 206, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(153, 102, 255, 0.2)',
          'rgba(255, 159, 64, 0.2)'
        ],
        borderColor: [
          'rgba(255, 99, 132, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
          'rgba(255, 159, 64, 1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
  var ctx = document.getElementById('myChart2').getContext('2d');
  const DATA_COUNT = 7;
  const NUMBER_CFG = {count: DATA_COUNT, min: -100, max: 100};

  const labels = ["a", "b"];
  const data = {
    labels: ["asd", "qwe"],
    datasets: [
      {
        label: 'My First dataset',
        data: [1,2],
        // borderColor: Utils.CHART_COLORS.red,
        // backgroundColor: Utils.CHART_COLORS.red,
        fill: true
      },
      {
        label: 'My Second dataset',
        data: [3,4],
        // borderColor: Utils.CHART_COLORS.blue,
        // backgroundColor: Utils.CHART_COLORS.blue,
        fill: true
      }
    ]
  }
  var myChart = new Chart(ctx, {
    type: 'line',
    data: data,
    options: {
      responsive: true,
      plugins: {
        title: {
          display: true,
          text: (ctx) => 'Chart.js Line Chart - stacked=' + ctx.chart.options.scales.y.stacked
        },
        tooltip: {
          mode: 'index'
        },
      },
      interaction: {
        mode: 'nearest',
        axis: 'x',
        intersect: false
      },
      scales: {
        x: {
          title: {
            display: true,
            text: 'Month'
          }
        },
        y: {
          stacked: true,
          title: {
            display: true,
            text: 'Value'
          }
        }
      }
    }
  });
}
