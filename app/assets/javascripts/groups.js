$(function () {

  $('.count').tooltip({delay: { show: 500, hide: 100 }});

  $.get('/treehousechart.json', function (json) {

    var seriesArray = [];
    $.each(json, function(name, data) {

      seriesArray.push({
        name: name,
        data: data,
        pointInterval: 24 * 3600 * 1000,
        marker: {
          radius: 0
        }
      })
    });

    if ($('#user_chart')[0]){
      $('#user_chart').highcharts({
      chart: {
        type: 'line',
        marginRight: 130,
        marginBottom: 25
      },
      title: {
        text: 'Group Star Chart',
        x: -20 //center
      },
      xAxis: {
        type: 'datetime',
        maxZoom: 130 * 24 * 3600000,
        title: {
          text: null
        }
      },
      yAxis: {
        title: {
          text: 'Stars'
      }},
      plotLines: [{
        value: 0,
        width: 1,
        color: '#808080'
      }],
      tooltip: {
        valueSuffix: ' stars'
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: 20,
        y: 100,
        borderWidth: 0
      },
      series: seriesArray
    });
    }
  });
});


